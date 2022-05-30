import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import '../Model/Daily_Alarm_Model.dart';
final String tableAlarm = 'daily_reminder';
final String columnId = 'ID';
final String columnTitle = 'title';
// final String columnDateTime = 'daily_time';
// final String columnPending = 'isPending';

class Helper {
  static Database? _database;
  static Helper? _alarmHelper;
Helper._createInstance();
  factory Helper() {
    if (_alarmHelper == null) {
      _alarmHelper = Helper._createInstance();
    }
    return _alarmHelper!;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    var path = dir + "alarm.db";

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          create table $tableAlarm ( 
          $columnId integer primary key autoincrement, 
          $columnTitle text not null,
      
          
          )
        ''');
      },
    );
    return database;
  }

  void insertAlarm(Daily_Alarm_Model alarmInfo) async {
    var db = await this.database;
    var result = await db.insert(tableAlarm, alarmInfo.toMap());
    print('result : $result');
  }

  Future<List<Daily_Alarm_Model>> getAlarms() async {
    List<Daily_Alarm_Model> _alarms = [];

    var db = await this.database;
    var result = await db.query(tableAlarm);
    result.forEach((element) {
      var alarmInfo = Daily_Alarm_Model.fromMap(element);
      _alarms.add(alarmInfo);
    });

    return _alarms;
  }

  Future<int> delete(int id) async {
    var db = await this.database;
    return await db.delete(tableAlarm, where: '$columnId = ?', whereArgs: [id]);
  }
}
