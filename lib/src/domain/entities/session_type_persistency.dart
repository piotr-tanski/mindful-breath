import 'package:breath/src/domain/entities/session_type.dart';

abstract class PersistentSessionType
{
  Future<List<SessionType>> selectAll();
  Future<void> insert(SessionType sessionType);
  Future<void> delete(SessionType sessionType);
}
