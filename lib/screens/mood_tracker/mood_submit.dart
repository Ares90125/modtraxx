import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../mood_log/mood_log.dart';
import '../../util/colors.dart';

class MoodTrackerSubmitScreen extends StatefulWidget {
  const MoodTrackerSubmitScreen({Key? key}) : super(key: key);

  @override
  _MoodTrackerSubmitScreenState createState() =>
      _MoodTrackerSubmitScreenState();
}

class _MoodTrackerSubmitScreenState extends State<MoodTrackerSubmitScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> updateUserStreak() async {
    int difference = 0;
    int currentStreak = 0;
    int longestStreak = 0;
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      currentStreak = value.data()!["current_streak"];
      longestStreak = value.data()!["longest_streak"];
      final now = DateTime.parse(formatter.format(DateTime.now()));
      DateTime dt1 =
          DateTime.parse(value.data()!["latest_log_time"].toDate().toString());
      DateTime latestLogTime = DateTime.parse(formatter.format(dt1));
      Duration diff = now.difference(latestLogTime);
      difference = diff.inDays;
      if (difference > 1) {
        FirebaseFirestore.instance.collection("users").doc(uid).update({
          "current_streak": 1,
          "longest_streak": longestStreak,
          "latest_log_time": DateTime.now()
        }).then((_) {
          print("success!");
        });
      } else if (difference == 1) {
        if (currentStreak >= longestStreak) {
          FirebaseFirestore.instance.collection("users").doc(uid).update({
            "current_streak": currentStreak + 1,
            "longest_streak": longestStreak + 1,
            "latest_log_time": DateTime.now()
          }).then((_) {
            print("success!");
          });
        } else {
          FirebaseFirestore.instance.collection("users").doc(uid).update({
            "current_streak": currentStreak + 1,
            "longest_streak": longestStreak,
            "latest_log_time": DateTime.now()
          }).then((_) {
            print("success!");
          });
        }
      }
    });
  }

  void submit() async {
    // Save the mood log in local stroage as shared preferences
    var jsonData = [];
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? url = _prefs.getString('url');
    String? rate = _prefs.getString('rate');
    String? hours = _prefs.getString('hours');
    String? notes = _prefs.getString('notes');
    url ??=
        'https://static.wixstatic.com/media/9039fb_cb978084fc164bfdabb7d76ac9d8ea01~mv2.gif';
    rate ??= '5';
    hours ??= '0';
    notes ??= '';
    final data = {
      "url": url,
      "rate": rate,
      "hours": hours,
      "note": notes,
      "date": DateFormat("MM/dd/yyyy").format(DateTime.now()).toString(),
      // "date": '03/13/2022',
      "time": DateFormat('hh:mm:ss').format(DateTime.now()).toString()
    };
    if (_prefs.getString('mood') == null) {
      jsonData = [];
    } else {
      jsonData = json.decode(_prefs.getString('mood') ?? '');
    }
    _prefs.setString('latestSubmitTime', DateTime.now().toString());
    jsonData.add(data);
    _prefs.setString('mood', json.encode(jsonData));
    final result = json.decode(_prefs.getString('mood') ?? '');
    var reversedResult = List.from(result.reversed);
  
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MoodLogScreen(logList: reversedResult),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
            child: Image.asset(
              'assets/icons/thumbs-up.png',
              width: MediaQuery.of(context).size.width * 0.25,
              fit: BoxFit.fitWidth,
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
            child: Text(
              'Thank you so much for being part of our community. We really appreciate the support. We hope that your day is amazing!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(40, 20, 40, 10),
            child: Text(
              'Sending good vibes and happy thoughts your way!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Color(0xff7F72E9),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(40, 20, 40, 10),
            child: Text(
              'Submit below, to add today\'s info to your daily journal.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                color: secondaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black87,
                  fixedSize: const Size(150, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    side: const BorderSide(color: Colors.white, width: 2),
                  ),
                ),
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Update Current Streak and Longest Streak
                  updateUserStreak();
                  // Submit Mood Log Data in Local Storage
                  submit();
                  // Initialize the local state of the variables
                  // clearData();
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xff4B39EF),
                  fixedSize: const Size(150, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    side: const BorderSide(color: Colors.blueAccent, width: 2),
                  ),
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
