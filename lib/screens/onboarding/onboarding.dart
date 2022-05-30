import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../auth/login.dart';
import './onboarding_page1.dart';
import './onboarding_page2.dart';
import './onboarding_page3.dart';
import '../../util/colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    final controller =
        PageController(viewportFraction: 1, keepPage: false, initialPage: 0);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset(
                'assets/images/MoodTraxx-Logo-Moon.png',
                width: 200,
                height: 100,
                fit: BoxFit.fitHeight,
              ),
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.65,
                child: PageView(
                  controller: controller,
                  pageSnapping: true,
                  children: const [
                    OnboardingPage1(),
                    OnboardingPage2(),
                    OnboardingPage3(),
                  ],
                ),
              ),
              SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: const ExpandingDotsEffect(
                  expansionFactor: 2,
                  spacing: 8,
                  radius: 16,
                  dotWidth: 16,
                  dotHeight: 4,
                  dotColor: Color(0x8AC6CAD4),
                  activeDotColor: Colors.white,
                  paintStyle: PaintingStyle.fill,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  fixedSize: const Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    side: const BorderSide(color: Colors.white54, width: 3),
                  ),
                ),
                child: const Text(
                  "Continue",
                  style: TextStyle(color: btnColor, fontSize: 22),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
