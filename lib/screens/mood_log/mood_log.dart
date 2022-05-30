import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './mood_item.dart';
import '../../util/colors.dart';
import '../homepage/home_page.dart';

class MoodLogScreen extends StatefulWidget {
  final List logList;
  const MoodLogScreen({Key? key, required this.logList}) : super(key: key);

  @override
  _MoodLogScreenState createState() => _MoodLogScreenState();
}

class _MoodLogScreenState extends State<MoodLogScreen> {
  List initialLogList = [];
  late SharedPreferences _prefs;
  int currentStreak = 0;
  int longestStreak = 0;
  @override
  void initState() {
    super.initState();
    print(widget.logList);
    _customInit();
    getStreaks();
  }

  void _customInit() async {
    _prefs = await SharedPreferences.getInstance();
    // _prefs.remove('mood');
    if (_prefs.getString('mood') == null) {
      initialLogList = [];
    } else {
      initialLogList = json.decode(_prefs.getString('mood') ?? '');
    }
  }

  Future getStreaks() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      setState(() {
        currentStreak = value.data()!['current_streak'];
        longestStreak = value.data()!['longest_streak'];
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Color(0xff4B39EF)),
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePageScreen(),
              ),
            );
          },
          child: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Image.asset(
            'assets/images/MoodTraxx-Logo-Light.png',
            width: 70,
            height: 70,
            fit: BoxFit.fitWidth,
          ),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text(
                  'Daily Mood Journal',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Color(0xFF4B39EF),
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 5,
                      color: Colors.white,
                      offset: Offset(0, 3),
                      spreadRadius: 3,
                    )
                  ],
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1A1351), Color(0xff4B39EF)],
                    stops: [0, 1],
                    begin: AlignmentDirectional(0, -1),
                    end: AlignmentDirectional(0, 1),
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: secondaryColor,
                    width: 3,
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              "Current Streak",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              "Longest Streak",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              currentStreak.toString(),
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  color: secondaryColor,
                                  fontSize: 27,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              longestStreak.toString(),
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  color: secondaryColor,
                                  fontSize: 27,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              "Days",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              "Days",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            flex: 5,
            child: ListView.builder(
              itemCount: widget.logList.length,
              itemBuilder: (context, index) {
                return MoodItem(logItem: widget.logList[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
