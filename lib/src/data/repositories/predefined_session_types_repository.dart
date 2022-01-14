import 'package:breath/src/domain/entities/session_params.dart';
import 'package:breath/src/domain/entities/session_type.dart';
import 'package:breath/src/domain/repositories/session_types_repository.dart';

class PredefinedSessionTypesRepository implements SessionTypesRepository
{
  final sessions = <SessionType>[
    SessionType("Box breathing",
        SessionParameters(inhale: const Duration(seconds: 4), holdBreath: const Duration(seconds: 4), exhale: const Duration(seconds: 4), holdEmptyLungs: const Duration(seconds: 4)),
        shortDescription: "It can heighten performance and concentration while also being a powerful stress reliever. You may find it particularly helpful if you have a lung disease",
        description: "Box breathing, also referred to as square breathing, is a deep breathing technique that can help you slow down your breathing. It works by distracting your mind as you count to four, calming your nervous system, and decreasing stress in your body.\n\n"
            "Box breathing is a simple but powerful relaxation technique that can help return your breathing pattern to a relaxed rhythm. It can clear and calm your mind, improving your focus.",
        predefined: true,
    ),
    SessionType("Deep breathing",
        SessionParameters(inhale: const Duration(seconds: 4), exhale: const Duration(seconds: 6)),
        shortDescription: "A powerful tool to ease stress and make you feel less anxious. With this technique, you'll learn how to take bigger breaths, all the way into your belly.",
        description: "Your breath is a powerful tool to ease stress and make you feel less anxious. Some simple breathing exercises can make a big difference if you make them part of your regular routine.\n\n"
            "Many breathing exercises take only a few minutes. When you have more time, you can do them for 10 minutes or more to get even greater benefits.",
        predefined: true,
    ),
    SessionType("4-7-8 breathing",
        SessionParameters(inhale: const Duration(seconds: 4), holdBreath: const Duration(seconds: 7), exhale: const Duration(seconds: 8)),
        shortDescription: "Practice 4-7-8 while falling asleep as it helps to fall asleep faster and improves sleep quality.",
        description: "The 4-7-8 breathing technique, also known as “relaxing breath,” involves breathing in for 4 seconds, holding the breath for 7 seconds, and exhaling for 8 seconds. This breathing pattern aims to reduce anxiety or help people get to sleep. Some proponents claim that the method helps people get to sleep in 1 minute.\n\n"
            "There is limited scientific research to support this method, but there is a lot of anecdotal evidence to suggest that this type of deep, rhythmic breathing is relaxing and may help ease people into sleep.",
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