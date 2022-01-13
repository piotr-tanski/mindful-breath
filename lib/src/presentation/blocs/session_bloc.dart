import 'package:breath/src/domain/entities/session.dart';
import 'package:breath/src/domain/entities/session_state.dart';
import 'package:breath/src/domain/use_cases/next_session_phase.dart';

import 'package:rxdart/rxdart.dart';
import 'package:async/async.dart';

class SessionBloc {
  SessionBloc(this._session, this._soundNotifier);

  Stream<SessionState> get states => _sessionStateSubject.stream;
  bool get isActive => _isSessionActive;

  Future<void> startSession() async {
    _isSessionActive = true;
    await _loop();
  }

  Future<void> _loop() async {
    final nextPhase = NextSessionPhaseUseCase(_session, _soundNotifier);
    while (_isSessionActive) {
      _sessionStateSubject.add(await nextPhase());
      await _waitForNextPhase();
    }
  }

  Future<void> _waitForNextPhase() async {
    _op = CancelableOperation.fromFuture(Future.delayed(_session.currentPhaseDuration));
    return _op?.valueOrCancellation();
  }

  void stopSession() {
    _isSessionActive = false;
    _op?.cancel();
    _session.reset();
  }

  void dispose() {
    _sessionStateSubject.close();
  }

  final Session _session;
  final SoundNotifier _soundNotifier;
  final _sessionStateSubject = PublishSubject<SessionState>();

  CancelableOperation? _op;
  bool _isSessionActive = false;
}