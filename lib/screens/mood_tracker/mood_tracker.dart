import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import './mood_tracker1.dart';
import './mood_tracker2.dart';
import './mood_tracker3.dart';
import './mood_submit.dart';

class MoodTrackerScreen extends StatefulWidget {
  const MoodTrackerScreen({Key? key}) : super(key: key);

  @override
  _MoodTrackerScreenState createState() => _MoodTrackerScreenState();
}

class _MoodTrackerScreenState extends State<MoodTrackerScreen> {
  @override
  void initState() {
    // Initialize the local state of the variables
    clearData();
    super.initState();
  }

  void clearData() async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final now = DateTime.parse(formatter.format(DateTime.now()));
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    // print(_prefs.getString('latestSubmitTime'));
    if (_prefs.getString('latestSubmitTime') != null) {
      final DateTime latestSubmitTime =
          formatter.parse(_prefs.getString('latestSubmitTime') ?? '');
      Duration diff = now.difference(latestSubmitTime);
      int difference = diff.inDays;
      if (difference >= 1) {
        _prefs.remove('hours');
      }
    }
    _prefs.remove('rate');
    _prefs.remove('notes');
  }

  @override
  Widget build(BuildContext context) {
    final controller =
        PageController(viewportFraction: 1, keepPage: false, initialPage: 0);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Color(0xff4B39EF)),
        automaticallyImplyLeading: true,
        title: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
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
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: Image.asset(
                      'assets/images/Mood-Tracker.png',
                      width: MediaQuery.of(context).size.width * 0.6,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: PageView(
                      controller: controller,
                      scrollDirection: Axis.vertical,
                      pageSnapping: true,
                      children: const [
                        MoodTracker1Screen(),
                        MoodTracker2Screen(),
                        MoodTracker3Screen(),
                        MoodTrackerSubmitScreen(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(-0.9, -0.95),
              child: SmoothPageIndicator(
                controller: controller,
                count: 4,
                axisDirection: Axis.vertical,
                effect: const ExpandingDotsEffect(
                  expansionFactor: 2,
                  spacing: 8,
                  radius: 16,
                  dotWidth: 10,
                  dotHeight: 8,
                  dotColor: Color(0xFF9E9E9E),
                  activeDotColor: Color(0xF407CE83),
                  paintStyle: PaintingStyle.stroke,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
