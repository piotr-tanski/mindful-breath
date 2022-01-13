import 'package:breath/src/domain/entities/session_type.dart';
import 'package:breath/src/domain/repositories/session_types_repository.dart';

class InMemorySessionTypesRepository implements SessionTypesRepository
{
  InMemorySessionTypesRepository(this.sessions);

  @override
  Future<List<SessionType>> getSessions() => Future(() => sessions);

  @override
  Future<void> addSession(SessionType sessionType) async => sessions.add(sessionType);

  @override
  Future<void> deleteSession(SessionType sessionType) async => sessions.remove(sessionType);

  final List<SessionType> sessions;
}