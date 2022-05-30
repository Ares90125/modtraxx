import 'package:flutter/material.dart';
import './my_goals.dart';
import '../../util/colors.dart';

class GoalsOnboardingScreen extends StatefulWidget {
  const GoalsOnboardingScreen({Key? key}) : super(key: key);

  @override
  _GoalsOnboardingScreenState createState() => _GoalsOnboardingScreenState();
}

class _GoalsOnboardingScreenState extends State<GoalsOnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Text(
                "Your Personal Goals",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
              child: Image.asset(
                'assets/images/goals_onboarding.png',
                width: 100,
                height: 100,
                fit: BoxFit.fitWidth,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: secondaryColor,
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: Text(
                    'Mood Traxx "GOALS", is the perfect way to set your life goals and achieve them. It’s time to make your dreams a reality! When setting goals, think about what you’d like to accomplish in the short term and in the long term. Your goals are always within your reach.  Please use this area as you see fit and tailor it to your personal needs.  No goal is too big or too small!  Have fun with it!  Create as many goals as you\'d like and come back to them often.',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xffECECEC),
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyGoalScreen(),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xff091249),
                  fixedSize: const Size(150, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    side: const BorderSide(color: Colors.white, width: 2),
                  ),
                ),
                child: const Text(
                  "Let's GO!",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
