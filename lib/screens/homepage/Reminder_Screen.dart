import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:grouped_buttons_ns/grouped_buttons_ns.dart';
import 'package:intl/intl.dart';
import 'package:moodtraxx/screens/homepage/Service/background_servies.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:group_button/group_button.dart';
import 'package:workmanager/workmanager.dart';
import '../../main.dart';
import 'Model/Custom_ReminderModel.dart';
import 'Model/Days_Model.dart';
import 'Model/Weekly_Alarm_Model.dart';
import 'Model/alarm_info.dart';
import 'Service/Switch_Servies.dart';
import 'helper/alarm_helper.dart';
import 'home_page.dart';

List checkListItems = [
  {
    "id": 0,
    "value": false,
    "title": "Sunday",
  },
  {
    "id": 1,
    "value": false,
    "title": "Monday",
  },
  {
    "id": 2,
    "value": false,
    "title": "Tuesday",
  },
  {
    "id": 3,
    "value": false,
    "title": "Wednesday",
  },
  {
    "id": 4,
    "value": false,
    "title": "Thursday",
  },
  {
    "id": 5,
    "value": false,
    "title": "Friday",
  },
  {
    "id": 6,
    "value": false,
    "title": "Saturday",
  },
];

class Reminder_Screen extends StatefulWidget {
  const Reminder_Screen({Key? key}) : super(key: key);

  @override
  State<Reminder_Screen> createState() => _Reminder_ScreenState();
}

class _Reminder_ScreenState extends State<Reminder_Screen>
    with TickerProviderStateMixin {
  bool status1 = false;
  String? selected_day;
  String day_chick = '';
  String? dat;
  int? weeklyday;
  List<int> coustomday = [];
  int i = 0;
  bool status2 = false;
  Future<List<AlarmInfo>>? _alarms;
  Future<List<Days_Model>>? _day_list;
  late List<AlarmInfo>? data_list_day = [];
  List<weekly_Alarm_Model>? data_list_weekly = [];
  List<Custom_Reminder_Model>? data_list_custom = [];
  String? formattedDate;
  final controller = GroupButtonController();
  bool status3 = false;
  DateTime? _alarmTime;
  DateTime? weekly_alarmTime;
  Switch_Servies _switch_servies = Switch_Servies();
  String? _alarmTimeString;
  String? day_with_database_weekly;
  String Week_time = "";
  List<AlarmInfo>? _currentAlarms;
  AlarmHelper _alarmHelper = AlarmHelper();
  TimeOfDay current_time = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();

  TimeOfDay week_time = TimeOfDay.now();
  bool _isChecked = true;
  String _currText = '';
  List<String>? List_of_Day_custom;
  StateSetter? _setState;
  List<String> text = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];
  TimeOfDay selectedTime = const TimeOfDay(hour: 8, minute: 00);

  Future WeeklyDataSaving(String day, String time) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("weekday", day);
    prefs.setString("weektime", time);
  }

  Future getPendingNotificationCount() async {
    List<PendingNotificationRequest> p =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    // print("aaa" + p.length.toString());
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<String> WeeklyTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? weektime = prefs.getString("weektime");
    // print(weektime);
    return weektime!;
  }

  getSwitchValues() async {
    status2 = await _switch_servies.getSwitchState();
    setState(() {});
  }

  getSwitchValues_Daily() async {
    status1 = await _switch_servies.Daily_getSwitchState();
    setState(() {});
  }

  getSwitchValues_weekly() async {
    status3 = await _switch_servies.Weekly_getSwitchState();
    setState(() {});
  }

  _selectTime_week(BuildContext context, selected) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: week_time,
      initialEntryMode: TimePickerEntryMode.dial,
    );

    if (timeOfDay != null && timeOfDay != week_time) {
      setState(() {
        final time = formatTimeOfDay(week_time);
        String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
        // print('weeks $formattedDate $time');
        final weekd = '$formattedDate $time';
        // print('weekly date $time');
        final moonLanding = DateTime.parse(formattedDate);
        // print( join(selectedDate,timeOfDay));
        week_time = timeOfDay;
        // DateTime dateTime = DateFormat('dd-MM-yyyy hh:mm a').parseLoose('$date $time');
        //final moonLanding = DateTime.parse('2022-04-07 11:00');
        DateTime scheduleAlarmDateTime;

        if (join(selected, timeOfDay).isAfter(DateTime.now())) {
          scheduleAlarmDateTime = join(selected, timeOfDay);
        } else {
          // print(join(selected,week_time));
          //  print(dateTime);

          //  scheduleAlarmDateTime = join(selected,week_time).add(Duration(days: 1));

        }
        print(join(selected, timeOfDay));
        print(timeOfDay);
        scheduleAlarm(join(selected, week_time));
        // scheduleAlarmDateTime = join(selected,week_time).add(Duration(days: 7));
      });
    }
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  void func(String days) {
    coustomday.clear();
    List<String> mid = [];
    mid.addAll(days.split(", "));
    // print(mid.length);
    setState(() {
      for (int j = 0; j < mid.length; j++) {
        for (int k = 0; k < 7; k++) {
          if (checkListItems[k]["title"].toString().contains(mid[j])) {
            coustomday.add(k);
            break;
          }
        }
      }
      List_of_Day_custom = [
        for (int j = 0; j < coustomday.length; j++)
          checkListItems[coustomday[j]]["title"]
      ];
    });
  }

  @override
  void initState() {
    setState(() {
      getSwitchValues();
      getSwitchValues_Daily();
      getSwitchValues_weekly();
      tz.initializeTimeZones();
      DateTime date = DateTime.now();
      // print("weekday is ${date.weekday}");
      _alarmHelper.initializeDatabase().then((value) async {
        // print('------database intialized');
        loadAlarms();

        // print(data_list_weekly!.length);
        //  day_with_database_weekly=(data_list_weekly!.length==null?"":data_list_weekly![4].day)!;
        // print(day_with_database_weekly);
        // formattedDate = DateFormat('kk:mm').format(data_list_day![0].alarmDateTime!);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Color(0xff4B39EF)),
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
          child: Image.asset(
            'assets/images/MoodTraxx-Logo-Light.png',
            width: 70,
            height: 70,
            fit: BoxFit.fitWidth,
          ),
        ),
        leading: InkWell(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePageScreen(),
              ),
            );
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 24,
          ),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.all(50),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        const Text('My Reminders',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Image.asset(
                            'assets/images/MoodTraxx.png',
                            width: 70,
                            height: 70,
                            fit: BoxFit.fitWidth,
                          ),
                        )
                      ],
                    )),
                if (data_list_day!.isEmpty)
                  Reminder_shap(
                      title: 'DAILY Reminder',
                      date: 'Daily @',
                      istrue: status1,
                      tap: () async {
                        var selectedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (selectedTime != null) {
                          final now = DateTime.now();
                          var selectedDateTime = DateTime(now.year, now.month,
                              now.day, selectedTime.hour, selectedTime.minute);
                          _alarmTime = selectedDateTime;
                          setState(() {
                            DateFormat('hh:mm a').format(selectedDateTime);
                            DateTime scheduleAlarmDateTime;
                            if (_alarmTime!.isAfter(DateTime.now()))
                              scheduleAlarmDateTime = _alarmTime!;
                            else
                              scheduleAlarmDateTime =
                                  _alarmTime!.add(Duration(days: 1));
                            if (_alarmHelper.dataExists() != true) {
                              if (data_list_day!.isEmpty) {
                                var alarmInfo = AlarmInfo(
                                    alarmDateTime: scheduleAlarmDateTime,
                                    //  gradientColorIndex: 1,
                                    title: 'Daily',
                                    gradientColorIndex: 2,
                                    isPending: 0,
                                    id: 0);
                                _alarmHelper.insertAlarm(alarmInfo);
                                print(scheduleAlarmDateTime);
                                status1
                                    ? scheduleAlarm(scheduleAlarmDateTime)
                                    : print("false");
                                loadAlarms();
                              } else {
                                var alarmInfo = AlarmInfo(
                                  alarmDateTime: DateTime.now(),
                                  //  gradientColorIndex: 1,
                                  title: 'Daily',
                                  gradientColorIndex: 2,
                                  isPending: 0,
                                  id: 0,
                                );
                                _alarmHelper.Update_Alarm(alarmInfo);
                                print('already data updated');
                              }
                            }
                          });
                        }
                        // _selectTime(context);
                      },
                      Toggle: (v) {
                        if (data_list_day!.isNotEmpty) {
                          status1
                              ? cancelNotification(0)
                              : scheduleAlarm(data_list_day![0].alarmDateTime!);
                          setState(() {
                            status1 = v;
                            _switch_servies.Daily_saveSwitchState(v);
                            print('Saved state is $status1');
                          });
                        }
                      })
                else
                  Reminder_shap(
                      title: 'DAILY Reminder',
                      date: 'Daily @ ' +
                          DateFormat('hh:mm a')
                              .format(data_list_day![0].alarmDateTime!),
                      istrue: status1,
                      tap: () async {
                        var selectedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(
                              data_list_day![0].alarmDateTime!),
                        );
                        if (selectedTime != null) {
                          final now = DateTime.now();
                          var selectedDateTime = DateTime(now.year, now.month,
                              now.day, selectedTime.hour, selectedTime.minute);
                          _alarmTime = selectedDateTime;
                          setState(() {
                            _alarmTimeString =
                                DateFormat('hh:mm a').format(selectedDateTime);
                            DateTime scheduleAlarmDateTime;
                            if (_alarmTime!.isAfter(DateTime.now()))
                              scheduleAlarmDateTime = _alarmTime!;
                            else
                              scheduleAlarmDateTime =
                                  _alarmTime!.add(Duration(days: 1));
                            if (_alarmHelper.dataExists() != true) {
                              if (!data_list_day!.isEmpty) {
                                print('already data is upload');
                                var alarmInfo = AlarmInfo(
                                  alarmDateTime: scheduleAlarmDateTime,
                                  //  gradientColorIndex: 1,
                                  title: 'Daily',
                                  gradientColorIndex: 2,
                                  // isPending: true,
                                  id: 0,
                                );
                                _alarmHelper.Update_Alarm(alarmInfo);
                                status1
                                    ? scheduleAlarm(scheduleAlarmDateTime)
                                    : print("false");
                                loadAlarms();
                              }
                            }
                          });
                        }
                        // _selectTime(context);
                      },
                      Toggle: (v) {
                        if (data_list_day!.isNotEmpty) {
                          status1
                              ? cancelNotification(0)
                              : scheduleAlarm(data_list_day![0].alarmDateTime!);
                          setState(() {
                            status1 = v;
                            _switch_servies.Daily_saveSwitchState(v);
                          });
                        }
                      }),
                if (data_list_weekly!.isEmpty)
                  Reminder_shap(
                      title: 'WEEKLY Reminder',
                      date: 'Weekly :',
                      istrue: status2,
                      tap: () async {
                        final data = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: StatefulBuilder(
                                // You need this, notice the parameters below:
                                builder: (BuildContext context,
                                    StateSetter setState) {
                                  _setState = setState;
                                  return Column(
                                    children: [
                                      Flexible(
                                          child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              children: [
                                                Column(
                                                  children: List.generate(
                                                    checkListItems.length,
                                                    (index) => CheckboxListTile(
                                                      controlAffinity:
                                                          ListTileControlAffinity
                                                              .leading,
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      dense: true,
                                                      title: Text(
                                                        checkListItems[index]
                                                            ["title"],
                                                        style: const TextStyle(
                                                          fontSize: 16.0,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      value:
                                                          checkListItems[index]
                                                              ["value"],
                                                      onChanged: (value) {
                                                        setState(() {
                                                          for (var element
                                                              in checkListItems) {
                                                            element["value"] =
                                                                false;
                                                          }
                                                          checkListItems[index]
                                                              ["value"] = value;
                                                          selected_day =
                                                              "${checkListItems[index]["title"]}";
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 320.0,
                                                  child: RaisedButton(
                                                    onPressed: () async {
                                                      setState(() {
                                                        dat = selected_day;
                                                        print(selected_day);
                                                      });

                                                      var selectedTime =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime:
                                                            TimeOfDay.now(),
                                                      );
                                                      if (selectedTime !=
                                                          null) {
                                                        final now =
                                                            DateTime.now();
                                                        var selectedDateTime =
                                                            DateTime(
                                                                now.year,
                                                                now.month,
                                                                now.day,
                                                                selectedTime
                                                                    .hour,
                                                                selectedTime
                                                                    .minute);
                                                        _alarmTime =
                                                            selectedDateTime;
                                                        setState(() {
                                                          //kk
                                                          Week_time = DateFormat(
                                                                  'hh:mm a')
                                                              .format(
                                                                  selectedDateTime);
                                                          DateTime
                                                              scheduleAlarmDateTime;
                                                          if (_alarmTime!
                                                              .isAfter(DateTime
                                                                  .now()))
                                                            scheduleAlarmDateTime =
                                                                _alarmTime!;
                                                          else
                                                            scheduleAlarmDateTime =
                                                                _alarmTime!.add(
                                                                    Duration(
                                                                        days:
                                                                            1));
                                                          var alarmInfo =
                                                              weekly_Alarm_Model(
                                                            alarmDateTime:
                                                                scheduleAlarmDateTime,
                                                            //  gradientColorIndex: 1,
                                                            title: selected_day,
                                                            day: selected_day,
                                                            // isPending: true,
                                                          );
                                                          _alarmHelper
                                                              .insertAlarm_Weeks(
                                                                  alarmInfo);
                                                          loadAlarms();
                                                          status2
                                                              ? scheduleAlarmWeekly(
                                                                  weeklyday!,
                                                                  alarmInfo
                                                                      .alarmDateTime!,
                                                                  8,
                                                                  "Weekly Reminder")
                                                              : print("false");
                                                        });
                                                      }
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      "Save",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    color:
                                                        const Color(0xFF1BC0C5),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),
                                    ],
                                  );
                                },
                              ),
                            );
                          },
                        );
                        setState(() {
                          day_chick = data;
                        });
                      },
                      Toggle: (v) {
                        if (data_list_weekly!.isNotEmpty) {
                          status2
                              ? cancelNotification(8)
                              : scheduleAlarmWeekly(
                                  weeklyday!,
                                  data_list_weekly![0].alarmDateTime!,
                                  8,
                                  "Weekly Reminder");
                          setState(() {
                            status2 = v;
                            _switch_servies.saveSwitchState(v);
                            print('Saved state is $status2');
                          });
                        }
                      })
                else
                  Reminder_shap(
                      title: 'WEEKLY Reminder',
                      date: 'Weekly : ' +
                          data_list_weekly![0].day! +
                          "/" +
                          DateFormat('hh:mm a')
                              .format(data_list_weekly![0].alarmDateTime!),
                      istrue: status2,
                      tap: () async {
                        setState(() {
                          for (int k = 0; k < 7; k++) {
                            if (data_list_weekly![0].day ==
                                checkListItems[k]["title"]) {
                              checkListItems[k]['value'] = true;
                            } else {
                              checkListItems[k]['value'] = false;
                            }
                          }
                        });
                        //kk
                        final data = await showDialog(
                          useSafeArea: false,
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: StatefulBuilder(
                                // You need this, notice the parameters below:
                                builder: (BuildContext context,
                                    StateSetter setState) {
                                  _setState = setState;
                                  return Column(
                                    children: [
                                      Flexible(
                                          child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              children: [
                                                Column(
                                                  children: List.generate(
                                                    checkListItems.length,
                                                    (index) => CheckboxListTile(
                                                      selected:
                                                          (data_list_weekly![0]
                                                                      .day! ==
                                                                  checkListItems[
                                                                          index]
                                                                      ["title"])
                                                              ? true
                                                              : false,
                                                      controlAffinity:
                                                          ListTileControlAffinity
                                                              .leading,
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      dense: true,
                                                      title: Text(
                                                        checkListItems[index]
                                                            ["title"],
                                                        style: const TextStyle(
                                                          fontSize: 16.0,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      value:
                                                          checkListItems[index]
                                                              ["value"],
                                                      onChanged: (value) {
                                                        setState(() {
                                                          for (var element
                                                              in checkListItems) {
                                                            element["value"] =
                                                                false;
                                                          }
                                                          checkListItems[index]
                                                              ["value"] = value;
                                                          selected_day =
                                                              "${checkListItems[index]["title"]}";
                                                          weeklyday =
                                                              checkListItems[
                                                                  index]["id"];
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 320.0,
                                                  child: RaisedButton(
                                                    onPressed: () async {
                                                      setState(() {
                                                        dat = selected_day;
                                                      });
                                                      var selectedTime =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                data_list_weekly![
                                                                        0]
                                                                    .alarmDateTime!),
                                                      );

                                                      if (selectedTime !=
                                                          null) {
                                                        final now =
                                                            DateTime.now();
                                                        var selectedDateTime =
                                                            DateTime(
                                                                now.year,
                                                                now.month,
                                                                now.day,
                                                                selectedTime
                                                                    .hour,
                                                                selectedTime
                                                                    .minute);
                                                        setState(() {
                                                          _alarmTime =
                                                              selectedDateTime;
                                                          //kk
                                                          Week_time = DateFormat(
                                                                  'hh:mm a')
                                                              .format(
                                                                  selectedDateTime);
                                                          DateTime
                                                              scheduleAlarmDateTime;
                                                          if (_alarmTime!
                                                              .isAfter(DateTime
                                                                  .now())) {
                                                            scheduleAlarmDateTime =
                                                                _alarmTime!;
                                                          } else {
                                                            scheduleAlarmDateTime =
                                                                _alarmTime!.add(
                                                                    const Duration(
                                                                        days:
                                                                            1));
                                                          }
                                                          var alarmInfo =
                                                              weekly_Alarm_Model(
                                                                  alarmDateTime:
                                                                      scheduleAlarmDateTime,
                                                                  title:
                                                                      'weekly',
                                                                  day:
                                                                      selected_day,
                                                                  id: 0);
                                                          print(
                                                              "d" + day_chick);
                                                          _alarmHelper
                                                              .Update_Alarm_Weekly(
                                                                  alarmInfo);
                                                          loadAlarms();
                                                          status2
                                                              ? scheduleAlarmWeekly(
                                                                  weeklyday!,
                                                                  alarmInfo
                                                                      .alarmDateTime!,
                                                                  8,
                                                                  "Weekly Reminder")
                                                              : print("false");
                                                        });
                                                      }
                                                      day_chick = selected_day!;
                                                      print(
                                                          'this is day chick');
                                                      print(day_chick);
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      "Save",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    color:
                                                        const Color(0xFF1BC0C5),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),
                                    ],
                                  );
                                },
                              ),
                            );
                          },
                        );
                        setState(() {
                          if (data != null) {
                            day_chick = data;
                          }
                        });
                      },
                      Toggle: (v) {
                        if (data_list_weekly!.isNotEmpty) {
                          status2
                              ? cancelNotification(8)
                              : scheduleAlarmWeekly(
                                  weeklyday!,
                                  data_list_weekly![0].alarmDateTime!,
                                  8,
                                  "Weekly Reminder");
                          setState(() {
                            status2 = v;
                            _switch_servies.saveSwitchState(v);
                            print('Saved state is $status2');
                          });
                        }
                      }),
                if (data_list_custom!.isEmpty)
                  Reminder_shap(
                      title: 'CUSTOM Reminder',
                      date: '@',
                      istrue: status3,
                      tap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                  builder: (context, setState) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  //this right here
                                  child: Column(
                                    children: [
                                      Flexible(
                                          child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              children: [
                                                CheckboxGroup(
                                                    labels: text,
                                                    onSelected:
                                                        (List<String> checked) {
                                                      List_of_Day_custom =
                                                          checked;
                                                      print(List_of_Day_custom);
                                                    }),
                                                SizedBox(
                                                  width: 320.0,
                                                  child: RaisedButton(
                                                    onPressed: () async {
                                                      controller.selectIndex(1);
                                                      var selectedTime =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime:
                                                            TimeOfDay.now(),
                                                      );
                                                      if (selectedTime !=
                                                          null) {
                                                        final now =
                                                            DateTime.now();
                                                        var selectedDateTime =
                                                            DateTime(
                                                                now.year,
                                                                now.month,
                                                                now.day,
                                                                selectedTime
                                                                    .hour,
                                                                selectedTime
                                                                    .minute);
                                                        _alarmTime =
                                                            selectedDateTime;
                                                        setState(() {
                                                          _alarmTimeString =
                                                              DateFormat(
                                                                      'hh:mm a')
                                                                  .format(
                                                                      selectedDateTime);
                                                          DateTime
                                                              scheduleAlarmDateTime;
                                                          if (_alarmTime!
                                                              .isAfter(DateTime
                                                                  .now())) {
                                                            scheduleAlarmDateTime =
                                                                _alarmTime!;
                                                          } else {
                                                            scheduleAlarmDateTime =
                                                                _alarmTime!.add(
                                                                    const Duration(
                                                                        days:
                                                                            1));
                                                          }
                                                          String days = "";
                                                          for (int j = 0;
                                                              j <
                                                                  List_of_Day_custom!
                                                                      .length;
                                                              j++) {
                                                            days +=
                                                                List_of_Day_custom![
                                                                        j]
                                                                    .substring(
                                                                        0, 3);
                                                            if (j !=
                                                                List_of_Day_custom!
                                                                        .length -
                                                                    1) {
                                                              days += ", ";
                                                            }
                                                          }
                                                          var alarmInfo =
                                                              Custom_Reminder_Model(
                                                            time:
                                                                scheduleAlarmDateTime,
                                                            Day: days,
                                                            title:
                                                                'alarm_custom',
                                                          );

                                                          _alarmHelper
                                                              .insert_Custom_Reminder(
                                                                  alarmInfo);

                                                          loadAlarms();
                                                          print(alarmInfo);
                                                          if (status3) {
                                                            if (coustomday
                                                                .isNotEmpty) {
                                                              for (int j = 0;
                                                                  j <
                                                                      coustomday
                                                                          .length;
                                                                  j++) {
                                                                cancelNotification(
                                                                    coustomday[
                                                                            j] +
                                                                        1);
                                                              }
                                                            }
                                                            func(days);
                                                            for (int j = 0;
                                                                j <
                                                                    coustomday
                                                                        .length;
                                                                j++) {
                                                              scheduleAlarmWeekly(
                                                                  coustomday[j],
                                                                  scheduleAlarmDateTime,
                                                                  coustomday[
                                                                          j] +
                                                                      1,
                                                                  "Custom Reminder");
                                                            }
                                                          }
                                                          Navigator.pop(
                                                              context);
                                                        });
                                                      }
                                                    },
                                                    child: const Text(
                                                      "Save",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    color:
                                                        const Color(0xFF1BC0C5),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),
                                    ],
                                  ),
                                );
                              });
                            });
                      },
                      Toggle: (v) {
                        if (data_list_custom!.isNotEmpty) {
                          if (!status3) {
                            for (int j = 0; j < coustomday.length; j++) {
                              scheduleAlarmWeekly(
                                  coustomday[j],
                                  data_list_custom![0].time!,
                                  coustomday[j] + 1,
                                  "Custom Reminder");
                            }
                          } else {
                            for (int j = 0; j < coustomday.length; j++) {
                              cancelNotification(coustomday[j] + 1);
                            }
                          }
                          setState(() {
                            status3 = v;
                            _switch_servies.Weekly_saveSwitchState(v);
                            print('Saved state is $status3');
                          });
                        }
                      })
                else
                  Reminder_shap(
                      title: 'CUSTOM Reminder',
                      date: data_list_custom![0].Day! +
                          '@' +
                          DateFormat('hh:mm a')
                              .format(data_list_custom![0].time!),
                      istrue: status3,
                      tap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                  builder: (context, setState) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  //this right here
                                  child: Column(
                                    children: [
                                      Flexible(
                                          child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              children: [
                                                CheckboxGroup(
                                                    checked:
                                                        List_of_Day_custom!,
                                                    labels: text,
                                                    onSelected:
                                                        (List<String> checked) {
                                                      setState(() {
                                                        List_of_Day_custom =
                                                            checked;
                                                      });
                                                      print("aaa" +
                                                          List_of_Day_custom
                                                              .toString());
                                                    }),
                                                SizedBox(
                                                  width: 320.0,
                                                  child: RaisedButton(
                                                    onPressed: () async {
                                                      controller.selectIndex(1);
                                                      var selectedTime =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                data_list_custom![
                                                                        0]
                                                                    .time!),
                                                      );
                                                      if (selectedTime !=
                                                          null) {
                                                        final now =
                                                            DateTime.now();
                                                        var selectedDateTime =
                                                            DateTime(
                                                                now.year,
                                                                now.month,
                                                                now.day,
                                                                selectedTime
                                                                    .hour,
                                                                selectedTime
                                                                    .minute);
                                                        _alarmTime =
                                                            selectedDateTime;
                                                        setState(() {
                                                          _alarmTimeString =
                                                              DateFormat(
                                                                      'hh:mm a')
                                                                  .format(
                                                                      selectedDateTime);
                                                          DateTime
                                                              scheduleAlarmDateTime;
                                                          if (_alarmTime!
                                                              .isAfter(DateTime
                                                                  .now())) {
                                                            scheduleAlarmDateTime =
                                                                _alarmTime!;
                                                          } else {
                                                            scheduleAlarmDateTime =
                                                                _alarmTime!.add(
                                                                    const Duration(
                                                                        days:
                                                                            1));
                                                          }
                                                          String days = "";
                                                          for (int j = 0;
                                                              j <
                                                                  List_of_Day_custom!
                                                                      .length;
                                                              j++) {
                                                            days +=
                                                                List_of_Day_custom![
                                                                        j]
                                                                    .substring(
                                                                        0, 3);
                                                            if (j !=
                                                                List_of_Day_custom!
                                                                        .length -
                                                                    1) {
                                                              days += ", ";
                                                            }
                                                          }
                                                          var alarmInfo =
                                                              Custom_Reminder_Model(
                                                                  time:
                                                                      scheduleAlarmDateTime,
                                                                  Day: days,
                                                                  title:
                                                                      'alarm_custom',
                                                                  isPending:
                                                                      true,
                                                                  id: 0);
                                                          _alarmHelper
                                                              .Update_Custom_Reminder(
                                                                  alarmInfo);
                                                          loadAlarms();
                                                          if (status3) {
                                                            if (coustomday
                                                                .isNotEmpty) {
                                                              for (int j = 0;
                                                                  j <
                                                                      coustomday
                                                                          .length;
                                                                  j++) {
                                                                cancelNotification(
                                                                    coustomday[
                                                                            j] +
                                                                        1);
                                                              }
                                                            }
                                                            func(days);
                                                            for (int j = 0;
                                                                j <
                                                                    coustomday
                                                                        .length;
                                                                j++) {
                                                              scheduleAlarmWeekly(
                                                                  coustomday[j],
                                                                  scheduleAlarmDateTime,
                                                                  coustomday[
                                                                          j] +
                                                                      1,
                                                                  "Custom Reminder");
                                                            }
                                                          }
                                                          Navigator.pop(
                                                              context);
                                                        });
                                                      }
                                                    },
                                                    child: const Text(
                                                      "Save",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    color:
                                                        const Color(0xFF1BC0C5),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),
                                    ],
                                  ),
                                );
                              });
                            });
                      },
                      Toggle: (v) {
                        if (data_list_custom!.isNotEmpty) {
                          if (!status3) {
                            print(coustomday);
                            for (int j = 0; j < coustomday.length; j++) {
                              scheduleAlarmWeekly(
                                  coustomday[j],
                                  data_list_custom![0].time!,
                                  coustomday[j] + 1,
                                  "Custom Reminder");
                            }
                          } else {
                            for (int j = 0; j < coustomday.length; j++) {
                              cancelNotification(coustomday[j] + 1);
                            }
                          }
                          setState(() {
                            status3 = v;
                            _switch_servies.Weekly_saveSwitchState(v);
                            print('Saved state is $status3');
                          });
                        }
                      })
              ],
            ),
          ),
        ),
      ),
    );
  }

  DateTime join(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  void loadAlarms() async {
    data_list_day = (await _alarmHelper.getAlarms()).cast<AlarmInfo>();
    data_list_weekly =
        (await _alarmHelper.get_weekly_reminder()).cast<weekly_Alarm_Model>();
    data_list_custom = (await _alarmHelper.get_custom_reminder())
        .cast<Custom_Reminder_Model>();
    if (mounted) {
      if (data_list_weekly!.isNotEmpty) {
        setState(() {
          for (int k = 0; k < 7; k++) {
            if (data_list_weekly![0].day == checkListItems[k]["title"]) {
              weeklyday = k;
              checkListItems[k]['value'] = true;
              break;
            }
          }
        });
      }
      if (data_list_custom!.isNotEmpty) {
        func(data_list_custom![0].Day!);
      }

      // setState(() {
      //   _alarms = _alarmHelper.getAlarms();
      //   print('this is alarm list ${data_list_day![0].alarmDateTime!}');
      //   print('this is alarm list ${data_list_custom![0].time!}');
      //   _day_list = _alarmHelper.getday();
      // });
    }
  }

  void scheduleAlarmWeekly(int day, DateTime time, int id, String title) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            color: Colors.black,
            priority: Priority.high,
            icon: 'mood_tracker',
            largeIcon: DrawableResourceAndroidBitmap('mood_tracker'),
            ticker: 'ticker',
            playSound: true,
            sound: RawResourceAndroidNotificationSound('sound'),
            styleInformation:
                BigTextStyleInformation('Check in with Mood Traxx Today'));

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
      sound: 'sound.mp3',
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    Day insideday = Day(day + 1);
    Time insidetime = Time(time.hour, time.minute);
    print('this is week time ${time}');
    await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
        id, title, title, insideday, insidetime, platformChannelSpecifics);
    getPendingNotificationCount();
  }

  void scheduleAlarm(DateTime scheduledNotificationDateTime) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            color: Colors.black,
            priority: Priority.high,
            icon: 'mood_tracker',
            largeIcon: DrawableResourceAndroidBitmap('mood_tracker'),
            ticker: 'ticker',
            playSound: true,
            sound: RawResourceAndroidNotificationSound('sound'),
            styleInformation:
                BigTextStyleInformation('Check in with Mood Traxx Today'));

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        sound: "sound.mp3",
        presentAlert: true,
        presentBadge: true,
        presentSound: true);
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    Day day = Day(scheduledNotificationDateTime.day);

    Time time = Time(scheduledNotificationDateTime.hour,
        scheduledNotificationDateTime.minute);
    Time tim = Time(scheduledNotificationDateTime.hour,
        scheduledNotificationDateTime.minute);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
      0,
      'Daily Reminder',
      'Daily Reminder',
      tim,
      platformChannelSpecifics,
    );
    getPendingNotificationCount();
  }

  Widget Reminder_shap({
    String? title,
    String? date,
    bool? istrue,
    ValueChanged<bool>? Toggle,
    GestureTapCallback? tap,
  }) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Container(
                decoration: new BoxDecoration(
                    color: Color(0xff262626),
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(10.0),
                      topRight: const Radius.circular(10.0),
                      bottomRight: const Radius.circular(10.0),
                      bottomLeft: const Radius.circular(10.0),
                    )),
                child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(2),
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    // borderRadius: BorderRadius.circular(100),
                                    Border.all(width: 1, color: Colors.white)),
                            child: SvgPicture.asset('assets/svg/n_icon.svg',
                                semanticsLabel: 'Acme Logo'),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                            child: new Text(
                          title!,
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        )),
                        Spacer(),
                        FlutterSwitch(
                          width: 50.0,
                          height: 25,
                          toggleSize: 30.0,
                          value: istrue!,
                          borderRadius: 30.0,
                          padding: 2.0,
                          toggleColor: Color.fromRGBO(225, 225, 225, 1),
                          switchBorder: Border.all(
                            color: Colors.white,
                            width: 1.0,
                          ),
                          activeColor: Color(0xff514CD2),
                          inactiveColor: Colors.black38,
                          onToggle: Toggle!,
                        ),
                      ],
                    )),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Container(
                decoration: const BoxDecoration(
                    color: Color(0xffC2C2C2),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                    )),
                child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: Container(child: Text('${date!}')),
                        ),
                        Spacer(),
                        Container(
                            padding: const EdgeInsets.all(10),
                            child:
                                InkWell(onTap: tap, child: const Text('SET'))),
                      ],
                    )),
              ),
            ),
          ],
        ));
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(width: 3.0),
    );
  }

  void data() {
    _setState!(() {});
  }
}
