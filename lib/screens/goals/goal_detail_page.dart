import 'package:flutter/material.dart';
import 'package:moodtraxx/screens/goals/goal_complete_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import './my_goals.dart';

class GoalDetailPage extends StatefulWidget {
  final int index;
  final dynamic goalItem;

  const GoalDetailPage({Key? key, required this.index, required this.goalItem})
      : super(key: key);

  @override
  _GoalDetailPageState createState() => _GoalDetailPageState();
}

class _GoalDetailPageState extends State<GoalDetailPage> {
  @override
  void initState() {
    super.initState();
    // print(widget.goalItem);
  }

  void completeGoal() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    final updatedData = {
      "goalName": widget.goalItem['goalName'],
      "goalDescription": widget.goalItem['goalDescription'],
      "goalDate": widget.goalItem['goalDate'],
      "completion": 'true',
      "created_at": widget.goalItem['created_at'],
    };
    var originalData = json.decode(_prefs.getString('goals') ?? '');
    var reversedOrigin = List.from(originalData.reversed);
    reversedOrigin[widget.index] = updatedData;
    var result = List.from(reversedOrigin.reversed);
    _prefs.setString('goals', json.encode(result));

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const GoalCompleteSplashScreen(),
      ),
    );
  }

  void undoComplete() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    final updatedData = {
      "goalName": widget.goalItem['goalName'],
      "goalDescription": widget.goalItem['goalDescription'],
      "goalDate": widget.goalItem['goalDate'],
      "completion": 'false',
      "created_at": widget.goalItem['created_at'],
    };
    var originalData = json.decode(_prefs.getString('goals') ?? '');
    var reversedOrigin = List.from(originalData.reversed);
    reversedOrigin[widget.index] = updatedData;
    var result = List.from(reversedOrigin.reversed);
    _prefs.setString('goals', json.encode(result));
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MyGoalScreen(),
      ),
    );
  }

  void removeGoalItem() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    var originalData = json.decode(_prefs.getString('goals') ?? '');
    var reversedOrigin = List.from(originalData.reversed);
    reversedOrigin.removeAt(widget.index);
    var result = List.from(reversedOrigin.reversed);
    _prefs.setString('goals', json.encode(result));
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MyGoalScreen(),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Ok"),
      onPressed: () {
        removeGoalItem();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Delete Goal"),
      content: const Text("Would you like to delete this goal data?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        automaticallyImplyLeading: true,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Image.asset(
            'assets/images/MoodTraxx-Logo-Light.png',
            width: 70,
            height: 70,
            fit: BoxFit.fitWidth,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              showAlertDialog(context);
            },
            child: const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 3, 16, 0),
              child: Icon(
                Icons.delete,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 400,
            decoration: BoxDecoration(
              color: const Color(0xFF121111),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
              ),
              border: Border.all(
                color: const Color(0xFF464646),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 16, 8),
                          child: Text(
                            widget.goalItem['goalName'],
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.white),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                widget.goalItem['goalDescription'],
                                style: const TextStyle(
                                  color: Color(0xffC0C5CB),
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(20, 6, 16, 8),
                          child: Text(
                            'Goal Date',
                            style: TextStyle(
                              color: Colors.white60,
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 6, 16, 8),
                          child: Text(
                            widget.goalItem['goalDate'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(20, 15, 16, 8),
                          child: Text(
                            'Creation Date',
                            style: TextStyle(
                              color: Colors.white60,
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 6, 16, 8),
                          child: Text(
                            widget.goalItem['created_at'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: TextButton(
                        onPressed: () {
                          undoComplete();
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.black,
                          fixedSize: const Size(150, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            side: const BorderSide(
                                color: Colors.white54, width: 2),
                          ),
                        ),
                        child: const Text(
                          "UNDO Complete",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: TextButton(
                        onPressed: () {
                          completeGoal();
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xff07CE83),
                          fixedSize: const Size(150, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            side: const BorderSide(
                                color: Colors.white54, width: 2),
                          ),
                        ),
                        child: const Text(
                          "Goal Completed",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
