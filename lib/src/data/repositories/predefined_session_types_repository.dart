import 'package:breath/src/domain/entities/session_params.dart';
import 'package:breath/src/domain/entities/session_type.dart';
import 'package:breath/src/domain/repositories/session_types_repository.dart';

class PredefinedSessionTypesRepository implements SessionTypesRepository
{
  final sessions = <SessionType>[
    SessionType("Box breathing",
        SessionParameters(inhale: const Duration(seconds: 4), holdBreath: const Duration(seconds: 4), exhale: const Duration(seconds: 4), holdEmptyLungs: const Duration(seconds: 4)),
        description: "It can heighten performance and concentration while also being a powerful stress reliever. You may find it particularly helpful if you have a lung disease",
        predefined: true,
    ),
    SessionType("Deep breathing",
        SessionParameters(inhale: const Duration(seconds: 4), exhale: const Duration(seconds: 6)),
        description: "A powerful tool to ease stress and make you feel less anxious. With this technique, you'll learn how to take bigger breaths, all the way into your belly.",
        predefined: true,
    ),
    SessionType("4-7-8 breathing",
        SessionParameters(inhale: const Duration(seconds: 4), holdBreath: const Duration(seconds: 7), exhale: const Duration(seconds: 8)),
        description: "The 4-7-8 breathing technique was developed by Dr. Andrew Weil. He refers to it as a \"natural tranquilizer for the nervous system\". Practice 4-7-8 while falling asleep as it helps to fall asleep faster and improves sleep quality.",
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