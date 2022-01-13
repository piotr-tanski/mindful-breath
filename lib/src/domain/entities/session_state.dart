import 'package:breath/src/domain/entities/session_phase.dart';

class SessionState
{
  SessionState(this.phase, this.duration);

  final SessionPhase phase;
  final Duration duration;
}