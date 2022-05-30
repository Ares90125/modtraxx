import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../util/colors.dart';

class MoodTracker2Screen extends StatefulWidget {
  const MoodTracker2Screen({Key? key}) : super(key: key);

  @override
  _MoodTracker2ScreenState createState() => _MoodTracker2ScreenState();
}

class _MoodTracker2ScreenState extends State<MoodTracker2Screen> {
  double sliderValue = 5.0;

  @override
  void initState() {
    initialRate();
    super.initState();
  }

  void initialRate() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString("rate", json.encode('5.0'));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Image.asset(
              'assets/images/zazzhands.gif',
              width: MediaQuery.of(context).size.width * 0.2,
              fit: BoxFit.fitWidth,
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: Text(
              'Rate Your Mood',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: secondaryColor,
                fontSize: 25,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/Sad.png',
                  width: 45,
                  height: 45,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(80, 0, 80, 0),
                  child: Image.asset(
                    'assets/icons/Glad.png',
                    width: 45,
                    height: 45,
                    fit: BoxFit.cover,
                  ),
                ),
                Image.asset(
                  'assets/icons/Mad.png',
                  width: 45,
                  height: 45,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'SAD',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(84, 0, 83, 0),
                  child: Text(
                    'GLAD',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  'MAD',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
            child: Container(
              width: 310,
              height: 40,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 5,
                    color: Colors.white,
                    spreadRadius: 2,
                  )
                ],
                gradient: const LinearGradient(
                  colors: [secondaryColor, Colors.black],
                  stops: [0, 1],
                  begin: AlignmentDirectional(0, 1),
                  end: AlignmentDirectional(0, -1),
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Slider(
                activeColor: Colors.blueAccent,
                inactiveColor: const Color(0xFF9E9E9E),
                min: 0,
                max: 10,
                value: sliderValue,
                label: sliderValue.toString(),
                divisions: 10,
                onChanged: (newValue) async {
                  setState(() => sliderValue = newValue);
                  final SharedPreferences _prefs =
                      await SharedPreferences.getInstance();
                  _prefs.setString("rate", json.encode(sliderValue.toString()));
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
            child: Container(
              height: 100,
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
    );
  }
}
