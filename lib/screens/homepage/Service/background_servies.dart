import 'package:intl/intl.dart';
import 'package:workmanager/workmanager.dart';

import '../Model/Weekly_Alarm_Model.dart';
import '../helper/alarm_helper.dart';

class background_servies {
  AlarmHelper _alarmHelper = AlarmHelper();

  void callbackDispatcher() {
    Workmanager().executeTask((taskName, inputData) async {
      List<weekly_Alarm_Model> list;
      list =
          (await _alarmHelper.get_weekly_reminder()).cast<weekly_Alarm_Model>();
      var datee = DateTime.now();
      print(
          datee.toString()); // prints something like 2019-12-10 10:02:22.287949
      print('${DateFormat('EEEE').format(datee)} this the converted date');
      var stringday = DateFormat('EEEE').format(datee);
      final data = list[0].day;
      //print('g=>$data');
      if (stringday == list[0].day) {
        // scheduleAlarmWeekly(1, DateTime.now());
      }

      return Future.value(true);
    });
  }
}
