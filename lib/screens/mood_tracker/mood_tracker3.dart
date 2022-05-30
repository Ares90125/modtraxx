import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../util/colors.dart';

class MoodTracker3Screen extends StatefulWidget {
  const MoodTracker3Screen({Key? key}) : super(key: key);

  @override
  _MoodTracker3ScreenState createState() => _MoodTracker3ScreenState();
}

class _MoodTracker3ScreenState extends State<MoodTracker3Screen> {
  int sleepHours = 0;
  int additionHours = 0;
  TextEditingController myTextFieldController = TextEditingController();

  @override
  void initState() {
    initialData();
    super.initState();
  }

  void initialData() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (_prefs.getString('hours') != null) {
      setState(() {
        sleepHours = int.parse(json.decode(_prefs.getString('hours') ?? '0'));
      });
      if (int.parse(json.decode(_prefs.getString('hours') ?? '0')) == 24) {
        _prefs.setString("hours", json.encode('0'));
        setState(() {
          sleepHours = 0;
        });
      }
    }
    _prefs.setString("notes", json.encode(''));
  }

  void saveData(int hours, String item) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString("url", json.encode(item));
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Center(
      child: SingleChildScrollView(
        reverse: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Image.asset(
                'assets/icons/sleeping.gif',
                width: MediaQuery.of(context).size.width * 0.25,
                fit: BoxFit.fitWidth,
              ),
            ),
            const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
              child: Text(
                'Hours Of Sleep For Today',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: secondaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Container(
                width: 200,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xff4B39EF),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: const Color(0xff4B39EF),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final SharedPreferences _prefs =
                            await SharedPreferences.getInstance();
                        if (additionHours > 0) {
                          setState(() {
                            additionHours--;
                          });
                        }
                        _prefs.setString(
                            "hours",
                            json.encode(
                                (sleepHours + additionHours).toString()));
                      },
                      child: const Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    Text(
                      (additionHours + sleepHours).toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (additionHours < 24 - sleepHours) {
                          setState(() {
                            additionHours++;
                          });
                        }
                        final SharedPreferences _prefs =
                            await SharedPreferences.getInstance();
                        _prefs.setString(
                            "hours",
                            json.encode(
                                (sleepHours + additionHours).toString()));
                      },
                      child: const Icon(
                        Icons.add,
                        color: Color(0xffFF5963),
                        size: 30,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Image.asset(
                'assets/images/Line.png',
                width: 200,
                height: 20,
                fit: BoxFit.cover,
              ),
            ),
            const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
              child: Text(
                'Your Final Thoughts...',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 30, 20, bottom),
              child: TextFormField(
                controller: myTextFieldController,
                maxLines: 6,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  isDense: true,
                  labelText: 'Type here...',
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                  ),
                  hintText: 'Type here...',
                  hintStyle: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: secondaryColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: secondaryColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  filled: true,
                  fillColor: const Color(0xff091249),
                  prefixIcon: const Icon(
                    Icons.notes_rounded,
                    color: Colors.white,
                  ),
                ),
                onChanged: (value) async {
                  final SharedPreferences _prefs =
                      await SharedPreferences.getInstance();
                  _prefs.setString("notes", json.encode(value));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Container(
                height: 90,
                decoration: const BoxDecoration(),
                child: Image.asset(
                  'assets/images/SwipeUp2.gif',
                  width: 100,
                  height: 100,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
