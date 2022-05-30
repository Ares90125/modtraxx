import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import '../Model/Custom_ReminderModel.dart';
import '../Model/Days_Model.dart';
import '../Model/Weekly_Alarm_Model.dart';
import '../Model/alarm_info.dart';

final String tableAlarm = 'alarm';
final String tableweeksAlarm = 'weeksAlarm';
final String tableCustomAlarm = 'CustomAlarm';
final String tableday = 'days';
final String columnId = 'id';
final String columnTitle = 'title';
final String columnDateTime = 'alarmDateTime';
final String columnPending = 'isPending';
final String columnColorIndex = 'gradientColorIndex';
final String columnday = 'day';
final String columnDateTime_weeks = 'weeksDateTime';
final String columnDays = 'day';
final String columntime = 'time';
final String column_value = 'value';

class AlarmHelper {
  static Database? _database;
  static AlarmHelper? _alarmHelper;
  int flag = (false) ? 1 : 0;
  AlarmHelper._createInstance();
  factory AlarmHelper() {
    if (_alarmHelper == null) {
      _alarmHelper = AlarmHelper._createInstance();
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
    print(path);
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
            '''
          create table $tableAlarm ( 
          $columnId integer primary key autoincrement, 
          $columnTitle text not null,
          $columnDateTime text not null,
          $columnPending integer,
          $columnColorIndex integer)
        ''');
        db.execute(
            '''
          create table $tableweeksAlarm ( 
          $columnId integer primary key autoincrement, 
          $columnTitle text not null,
          $columnDateTime_weeks text not null,
          $columnPending integer,
          $columnday text not  null)
        ''');
        db.execute(
            '''
          create table $tableCustomAlarm ( 
          $columnId integer primary key autoincrement, 
          $columnTitle text not null,
          $columnDays text not null,
          $columnPending integer,
          $columntime text not null)
        ''');
        db.execute(
            '''
          create table $tableday ( 
          $columnId integer primary key autoincrement, 
          $columnDays text not null ,
          $column_value integer
          )
        ''');
      },
    );

    final flag2 = (flag == 1) ? true : false;
    // insertdays([
    //   Days_Model(
    //   value: 0,
    //   Day: 'Monday'
    //
    // ),
    //   Days_Model(
    //       value: 0,
    //       Day: 'Tuesday'
    //
    //   ),
    //   Days_Model(
    //       value: 0,
    //       Day: 'Wednesday'
    //
    //   ),
    //   Days_Model(
    //       value: 0,
    //       Day: 'Thursday'
    //
    //   ),
    //   Days_Model(
    //       value: 0,
    //       Day: 'Friday'
    //   ),
    //   Days_Model(
    //       value: 0,
    //       Day: 'Saturday'
    //
    //   ),
    //   Days_Model(
    //       value: 0,
    //       Day: 'Sunday'
    //
    //   )
    // ]);
    return database;
  }

  void insertAlarm(AlarmInfo alarmInfo) async {
    var db = await this.database;
    var result = await db.insert(tableAlarm, alarmInfo.toMap());
    print('result : $result');
  }

  void Update_Alarm(AlarmInfo alarmInfo) async {
    var db = await this.database;
    var result = await db.update(tableAlarm, alarmInfo.toMap());
    print('result : $result');
  }

  void Delete_Custom() async {
    var db = await this.database;
    var result = await db.delete(tableCustomAlarm);
    print('result : $result');
  }

  void Update_Alarm_Weekly(weekly_Alarm_Model alarmInfo) async {
    var db = await this.database;
    var result = await db.update(tableweeksAlarm, alarmInfo.toMap());
    print('result : $result');
  }

  void insertAlarm_Weeks(weekly_Alarm_Model alarmInfo) async {
    var db = await this.database;
    var result = await db.insert(tableweeksAlarm, alarmInfo.toMap());
    print('result : $result');
  }

  void insert_Custom_Reminder(Custom_Reminder_Model alarmInfo) async {
    var db = await this.database;
    var result = await db.insert(tableCustomAlarm, alarmInfo.toMap());
    print('result : $result');
  }

  void Update_Custom_Reminder(Custom_Reminder_Model alarmInfo) async {
    var db = await this.database;
    var result = await db.update(tableCustomAlarm, alarmInfo.toMap());
    print('result : $result');
  }

  Future<int> insertdays(List<Days_Model> days) async {
    int result = 0;
    var db = await this.database;
    for (var user in days) {
      result = await db.insert(tableday, user.toMap());
    }
    return result;
  }

  Future<List<AlarmInfo>> getAlarms() async {
    List<AlarmInfo> _alarms = [];
    var db = await this.database;
    var result = await db.query(tableAlarm);
    result.forEach((element) {
      var alarmInfo = AlarmInfo.fromMap(element);
      _alarms.add(alarmInfo);
    });
    return _alarms;
  }

  Future<List<weekly_Alarm_Model>> get_weekly_reminder() async {
    List<weekly_Alarm_Model> _alarms = [];

    var db = await this.database;
    var result = await db.query(tableweeksAlarm);
    result.forEach((element) {
      var alarmInfo = weekly_Alarm_Model.fromMap(element);
      _alarms.add(alarmInfo);
    });

    return _alarms;
  }

  Future<List<Custom_Reminder_Model>> get_custom_reminder() async {
    List<Custom_Reminder_Model> _alarms = [];

    var db = await this.database;
    var result = await db.query(tableCustomAlarm);
    result.forEach((element) {
      var alarmInfo = Custom_Reminder_Model.fromMap(element);

      _alarms.add(alarmInfo);
    });

    return _alarms;
  }

  Future<List<Days_Model>> getday() async {
    List<Days_Model> _alarms = [];

    var db = await this.database;
    var result = await db.query(tableday);
    result.forEach((element) {
      var alarmInfo = Days_Model.fromMap(element);
      _alarms.add(alarmInfo);
    });

    return _alarms;
  }

  Future<int> delete(int id) async {
    var db = await this.database;
    return await db.delete(tableAlarm, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<bool> dataExists() async {
    var db = await this.database;
    var result = await db.rawQuery(
      'SELECT EXISTS(SELECT 1 FROM alarm)',
    );
    int? exists = Sqflite.firstIntValue(result);
    return exists == 1;
  }
}
