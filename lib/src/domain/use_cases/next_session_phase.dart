import 'package:breath/src/domain/entities/session.dart';
import 'package:breath/src/domain/entities/session_state.dart';

abstract class SoundNotifier
{
  void play();
}

class NextSessionPhaseUseCase
{
  NextSessionPhaseUseCase(this._session, this._soundNotifier);

  Future<SessionState> call() {
    _session.nextPhase();
    _soundNotifier.play();
    return Future(() => SessionState(_session.currentPhase, _session.currentPhaseDuration));
  }

  final Session _session;
  final SoundNotifier _soundNotifier;
}