import 'package:breath/src/data/models/session_type_dao.dart';
import 'package:breath/src/data/repositories/in_memory_session_types_repository.dart';
import 'package:breath/src/domain/entities/session_type.dart';
import 'package:breath/src/domain/repositories/session_types_repository.dart';
import 'package:flutter/foundation.dart';

class CustomSessionTypesRepositoryFactory {
  static SessionTypesRepository create() {
    if (kIsWeb) {
      // sqflite library does not support web.
      return InMemoryCustomSessionTypesRepository();
    }
    return SQLiteCustomSessionTypesRepository();
  }
}

class InMemoryCustomSessionTypesRepository implements SessionTypesRepository
{
  @override
  Future<List<SessionType>> getSessions() => _repo.getSessions();

  @override
  Future<void> addSession(SessionType sessionType) => _repo.addSession(sessionType);

  @override
  Future<void> deleteSession(SessionType sessionType) => _repo.deleteSession(sessionType);

  final _repo = InMemorySessionTypesRepository([]);
}

class SQLiteCustomSessionTypesRepository implements SessionTypesRepository
{
  @override
  Future<List<SessionType>> getSessions() => _dao.selectAll();

  @override
  Future<void> addSession(SessionType sessionType) => _dao.insert(sessionType);

  @override
  Future<void> deleteSession(SessionType sessionType) => _dao.delete(sessionType);

  final _dao = SessionTypeDAO();
}