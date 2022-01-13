import 'package:breath/src/domain/entities/session_params.dart';
import 'package:breath/src/domain/entities/session_type.dart';
import 'package:breath/src/domain/repositories/session_types_repository.dart';

class PredefinedSessionTypesRepository implements SessionTypesRepository
{
  final sessions = <SessionType>[
    SessionType("Box breathing",
        SessionParameters(inhale: const Duration(seconds: 4), holdBreath: const Duration(seconds: 4), exhale: const Duration(seconds: 4), holdEmptyLungs: const Duration(seconds: 4)),
        description: "Few minutes of this exercise will make you calm down and help you focus on your tasks without making you feel sleepy.",
        predefined: true,
    ),
    SessionType("Coherent breathing",
        SessionParameters(inhale: const Duration(seconds: 4), exhale: const Duration(seconds: 6)),
        description: "Also referred to as deep breathing, helps to calm the body through its effect on the autonomic nervous system.",
        predefined: true,
    ),
    SessionType("4-7-8 breathing",
        SessionParameters(inhale: const Duration(seconds: 4), holdBreath: const Duration(seconds: 7), exhale: const Duration(seconds: 8)),
        description: "Practice 4-7-8 while falling asleep as it helps to fall asleep faster and improves sleep quality.",
        predefined: true,
    ),
  ];

  @override
  Future<List<SessionType>> getSessions() => Future(() => sessions);

  @override
  Future<void> addSession(SessionType sessionType) {
    // Sessions should not be added to the predefined repository.
    throw UnimplementedError();
  }

  @override
  Future<void> deleteSession(SessionType sessionType) {
    // Sessions should not be removed from predefined repository.
    throw UnimplementedError();
  }
}