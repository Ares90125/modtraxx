import 'package:flutter/material.dart';
import 'package:moodtraxx/screens/goals/my_goals.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class CreateGoalWidget extends StatefulWidget {
  const CreateGoalWidget({Key? key}) : super(key: key);

  @override
  _CreateGoalWidgetState createState() => _CreateGoalWidgetState();
}

class _CreateGoalWidgetState extends State<CreateGoalWidget> {
  TextEditingController goalName = TextEditingController();
  TextEditingController goalDescription = TextEditingController();
  TextEditingController goalDate = TextEditingController();

  void _presentDatePicker() {
    // showDatePicker is a pre-made funtion of Flutter
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2120))
        .then((pickedDate) {
      if (pickedDate != null) {
        String formattedDate = DateFormat('MM/dd/yyyy').format(pickedDate);
        //you can implement different kind of Date Format here according to your requirement
        setState(() {
          goalDate.text = formattedDate; //set output date to TextField value.
        });
      } else {
        print("Date is not selected");
      }
    });
  }

  void submitGoal() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (goalName.text != '' &&
        goalDescription.text != '' &&
        goalDate.text != '') {
      var jsonData = [];
      final data = {
        "goalName": goalName.text,
        "goalDescription": goalDescription.text,
        "goalDate": goalDate.text,
        "completion": 'false',
        "created_at":
            DateFormat('MM/dd/yyyy').format(DateTime.now()).toString(),
      };
      if (_prefs.getString('goals') == null) {
        jsonData = [];
      } else {
        jsonData = json.decode(_prefs.getString('goals') ?? '');
      }
      jsonData.add(data);
      _prefs.setString('goals', json.encode(jsonData));
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MyGoalScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 410,
        decoration: BoxDecoration(
          color: const Color(0x7D121111),
          boxShadow: const [
            BoxShadow(
              blurRadius: 7,
              color: Colors.black,
              offset: Offset(0, -2),
            )
          ],
          borderRadius: BorderRadius.circular(0),
          border: Border.all(
            color: const Color(0xFFD1DAE0),
          ),
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Add Goal',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 5, 16, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: const [
                  Text(
                    'Fill out details below to add a new goal.',
                    style: TextStyle(
                      color: Colors.white54,
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: TextFormField(
                controller: goalName,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Goal Name',
                  hintText: 'Enter your goal here...',
                  hintStyle: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xFFB0B3B9),
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                  ),
                  labelStyle: const TextStyle(color: Colors.white54),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFF464646),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFF464646),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: TextFormField(
                controller: goalDescription,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Details',
                  hintText: 'Enter description here...',
                  hintStyle: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xFFB0B3B9),
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                  ),
                  labelStyle: const TextStyle(color: Colors.white54),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFF464646),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFF464646),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.start,
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: TextFormField(
                controller: goalDate,
                readOnly: true,
                onTap: () {
                  _presentDatePicker();
                },
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Due Date',
                  hintText: 'Date here...',
                  hintStyle: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xFFB0B3B9),
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                  ),
                  labelStyle: const TextStyle(color: Colors.white54),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFF464646),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFF464646),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () async {
                      // final SharedPreferences _prefs = await SharedPreferences.getInstance();
                      // _prefs.remove("goals");
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0x004B39EF),
                      fixedSize: const Size(130, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: const BorderSide(color: Colors.white54, width: 1),
                      ),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      submitGoal();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xff2E2E2E),
                      fixedSize: const Size(130, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: const BorderSide(color: Colors.white, width: 1),
                      ),
                    ),
                    child: const Text(
                      "Create Goal",
                      style: TextStyle(
                          fontFamily: 'Semi',
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
