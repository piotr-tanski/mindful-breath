import 'package:breath/src/domain/entities/session_type.dart';

abstract class SessionTypesRepository
{
  Future<List<SessionType>> getSessions();
  Future<void> addSession(SessionType sessionType);
  Future<void> deleteSession(SessionType sessionType);
}

class NullSessionTypesRepository implements SessionTypesRepository
{
  @override
  Future<List<SessionType>> getSessions() => Future(() => []);

  @override
  Future<void> addSession(SessionType sessionType) => Future.delayed(Duration.zero);

  @override
  Future<void> deleteSession(SessionType sessionType) => Future.delayed(Duration.zero);
}