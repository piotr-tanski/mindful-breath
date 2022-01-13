import 'session_phase.dart';

class SessionParameters
{
  SessionParameters({required Duration inhale, Duration holdBreath = const Duration(), required Duration exhale, Duration holdEmptyLungs = const Duration()}) {
    _phases.addAll(<SessionPhase, Duration>{
      SessionPhase.inhale: inhale,
      SessionPhase.holdBreath: holdBreath,
      SessionPhase.exhale: exhale,
      SessionPhase.holdEmptyLungs: holdEmptyLungs,
    });
  }

  bool isValid() => isPhaseDefined(SessionPhase.inhale) && isPhaseDefined(SessionPhase.exhale); // At least inhale and exhale need to be defined.

  bool isPhaseDefined(SessionPhase phase) => getPhaseDuration(phase) != const Duration();

  Duration getPhaseDuration(SessionPhase phase) => _phases[phase] ?? const Duration();

  final Map<SessionPhase, Duration> _phases = { };
}