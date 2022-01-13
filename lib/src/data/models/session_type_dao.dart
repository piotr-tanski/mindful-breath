import 'package:breath/src/data/models/sqlite_db.dart';
import 'package:breath/src/domain/entities/session_params.dart';
import 'package:breath/src/domain/entities/session_phase.dart';
import 'package:breath/src/domain/entities/session_type.dart';
import 'package:breath/src/domain/entities/session_type_persistency.dart';

import 'package:sqflite/sqflite.dart';

Map<String, dynamic> convertToMap(SessionType sessionType) => {
    SessionTable.name: sessionType.name,
    SessionTable.description: sessionType.description,
    SessionTable.inhaleDuration: sessionType.parameters.getPhaseDuration(SessionPhase.inhale).inSeconds,
    SessionTable.holdBreathDuration: sessionType.parameters.getPhaseDuration(SessionPhase.holdBreath).inSeconds,
    SessionTable.exhaleDuration: sessionType.parameters.getPhaseDuration(SessionPhase.exhale).inSeconds,
    SessionTable.holdEmptyLungsDuration: sessionType.parameters.getPhaseDuration(SessionPhase.holdEmptyLungs).inSeconds,
  };

class SessionTypeDAO implements PersistentSessionType
{
  @override
  Future<List<SessionType>> selectAll() async {
    final db = await BreathDatabase.instance;

    final maps = await db.query(kSessionTableName);
    return List.generate(maps.length, (i) {
      return SessionType(
        maps[i][SessionTable.name],
        SessionParameters(
          inhale: Duration(seconds: maps[i][SessionTable.inhaleDuration]),
          holdBreath: Duration(seconds: maps[i][SessionTable.holdBreathDuration]),
          exhale: Duration(seconds: maps[i][SessionTable.exhaleDuration]),
          holdEmptyLungs: Duration(seconds: maps[i][SessionTable.holdEmptyLungsDuration])),
        description: maps[i][SessionTable.description],
        id: maps[i][SessionTable.id]
      );
    });
  }

  @override
  Future<void> insert(SessionType sessionType) async {
    final db = await BreathDatabase.instance;

    final id = await db.insert(
      kSessionTableName,
      convertToMap(sessionType),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
    sessionType.id = id;
  }

  @override
  Future<void> delete(SessionType sessionType) async {
    final db = await BreathDatabase.instance;

    await db.delete(
      kSessionTableName,
      where: '${SessionTable.id} = ?',
      whereArgs: [sessionType.id]
    );
  }
}