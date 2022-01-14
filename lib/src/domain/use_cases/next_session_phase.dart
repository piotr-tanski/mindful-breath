import 'package:breath/src/domain/entities/session.dart';
import 'package:breath/src/domain/entities/session_state.dart';
import 'package:breath/src/domain/services/next_phase_notifier.dart';

class NextSessionPhaseUseCase
{
  NextSessionPhaseUseCase(this._session, this._notifier);

  Future<SessionState> call() {
    _session.nextPhase();
    _notifier.notify();
    return Future(() => SessionState(_session.currentPhase, _session.currentPhaseDuration));
  }

  final Session _session;
  final NextPhaseNotifier _notifier;
}