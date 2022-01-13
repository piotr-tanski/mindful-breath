import 'package:sqflite/sqflite.dart';

const kDbName = 'breath.db';
const kDbVersion = 1;

const kSessionTableName = 'sessions';
class SessionTable {
  static const id = 'id';
  static const name = 'name';
  static const description = 'description';
  static const inhaleDuration = 'inhale_duration_sec';
  static const holdBreathDuration = 'hold_breath_duration_sec';
  static const exhaleDuration = 'exhale_duration_sec';
  static const holdEmptyLungsDuration = 'hold_empty_lungs_duration_sec';
}

class BreathDatabase
{
  static get instance => _db;

  static final _db = openDatabase(
      kDbName,
      onCreate: (db, version) {
        return db.execute('CREATE TABLE $kSessionTableName ('
            '${SessionTable.id} INTEGER PRIMARY KEY,'
            '${SessionTable.name} TEXT,'
            '${SessionTable.description} TEXT,'
            '${SessionTable.inhaleDuration} INTEGER,'
            '${SessionTable.holdBreathDuration} INTEGER,'
            '${SessionTable.exhaleDuration} INTEGER,'
            '${SessionTable.holdEmptyLungsDuration} INTEGER'
            ')');
      },
      version: kDbVersion
  );
}