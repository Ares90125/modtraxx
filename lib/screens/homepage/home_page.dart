import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../mood_traxx_content/mood_traxx_content.dart';
import '../mood_tracker/mood_tracker.dart';
import '../goals/goals_onboarding.dart';
import '../charts/chart_screen.dart';
import '../mood_log/mood_log.dart';
import '../about_us/about_us.dart';
import 'Reminder_Screen.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  var logdata = [];
  var reversedData = [];
  TextEditingController emailAddressfieldController = TextEditingController();
  DateTime preBackpress = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    String moodTraxxContent = 'https://www.moodtraxx.com/moodtraxxapp';
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Image.asset(
                'assets/images/MoodTraxx-Logo-Moon.png',
                width: MediaQuery.of(context).size.width,
                height: 333,
                fit: BoxFit.cover,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text(
                  'Your New Serenity...',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
              const Text(
                '"A Mindful Escape"',
                style: TextStyle(
                  fontFamily: 'Lexend Deca',
                  color: Color(0xFFC2CBCE),
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Divider(
                  thickness: 1,
                  color: Colors.white54,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: GestureDetector(
                  onTap: () async {
                    if (!await launch(moodTraxxContent)) {
                      throw 'Could not launch $moodTraxxContent';
                    }
                  },
                  child: Image.asset(
                    'assets/images/MoodTrackContent.png',
                    width: MediaQuery.of(context).size.width * 0.85,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MoodTrackerScreen(),
                      ),
                    );
                  },
                  child: Image.asset(
                    'assets/images/MoodTracker.png',
                    width: MediaQuery.of(context).size.width * 0.45,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final SharedPreferences _prefs =
                            await SharedPreferences.getInstance();
                        if (_prefs.getString('mood') == null) {
                          logdata = [];
                        } else {
                          logdata = json.decode(_prefs.getString('mood') ?? '');
                          reversedData = List.from(logdata.reversed);
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ChartScreen(logList: reversedData),
                          ),
                        );
                      },
                      child: Image.asset(
                        'assets/images/My_Charts.png',
                        width: MediaQuery.of(context).size.width * 0.4,
                        fit: BoxFit.cover,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        final SharedPreferences _prefs =
                            await SharedPreferences.getInstance();
                        if (_prefs.getString('mood') == null) {
                          logdata = [];
                        } else {
                          logdata = json.decode(_prefs.getString('mood') ?? '');
                          reversedData = List.from(logdata.reversed);
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MoodLogScreen(logList: reversedData),
                          ),
                        );
                      },
                      child: Image.asset(
                        'assets/images/Daily_Journal.png',
                        width: MediaQuery.of(context).size.width * 0.4,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AboutUsScreen(),
                          ),
                        );
                      },
                      child: Image.asset(
                        'assets/images/About_US.png',
                        width: MediaQuery.of(context).size.width * 0.4,
                        fit: BoxFit.cover,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GoalsOnboardingScreen(),
                          ),
                        );
                      },
                      child: Image.asset(
                        'assets/images/Goals.png',
                        width: MediaQuery.of(context).size.width * 0.4,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Reminder_Screen(),
                      ),
                    );
                  },
                  child: Image.asset(
                    'assets/images/my_r.png',
                    width: MediaQuery.of(context).size.width * 0.45,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
