import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../service/authentication.dart';
import '../onboarding/onboarding.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  String facebookUrl = 'https://www.facebook.com/MoodTraxxApp/';
  String instagramUrl = 'https://www.instagram.com/moodtraxxapp/';
  String youtubeUrl =
      'https://www.youtube.com/channel/UCVIEvIvKgAK3qd6GeaObjHw';
  String twitterUrl = 'https://twitter.com/Mood_Traxx';
  String tiktokUrl = 'https://www.tiktok.com/@mood_traxx';
  String privacyUrl = 'https://www.moodtraxx.com/privacy-policy';
  String termsUrl = 'https://www.moodtraxx.com/termsandconditions';
  String websiteUrl = 'https://www.moodtraxx.com/';

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
                child: Text(
                  "About Mood Traxx",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xff141414),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: const Color(0xffECECEC),
                    ),
                  ),
                  child: Column(
                    children: const [
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                        child: Text(
                          '     My name is Loren Gingerich.  I am the sole designer and content provider for Mood Traxx.  I am not a big tech company or any type of large corporation.  I am a photographer/videographer, graphic artist, audio tech and voice-over artist, just to name a few of my many talents.  I recently learned the art of UI design, to be able to create Mood Traxx. As an unorganized person myself, I felt the need to give the users of this app the tools they need to help them on their path to successful relaxation, sleep and happiness.  Having many pitfalls in my own life, I have come to realize the need of taking just a few moments out of your day for yourself, to give your mind a reset.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xffECECEC),
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
                        child: Text(
                          '     I think that we can all agree that it is not always that easy to make time for yourself.  No matter how hard we try, life seems to just get in the way.  I am offering you a tool to help you find those few moments of comfort and serenity, so you can go back into the world feeling refreshed and ready to conquer the day.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xffECECEC),
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
                        child: Text(
                          '     Mood Traxx is a self-help wellness app with a focus on the reduction of stress, depression & anxiety or for those that just need some help falling asleep. Mood Traxx was designed under the premise of "content alone is sometimes not enough."  This app provides multiple self-help tools to ease stress, anxiety and depression, all in one simple and easy to use application.  Mood Traxx includes a mood tracker, with daily notes and a fun emoji status, along with a personal goals list and a sleep/mood chart, so you can visually see your daily progress.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xffECECEC),
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
                        child: Text(
                          '     Mood Traxx is for self assessed wellness and entertainment purposes only and is in no way, shape or form a substitute for truly needed medical advise. Stress, depression and anxiety are very real symptoms that can effect one\'s life in many different ways.  In some instances, medical advice from a professional should be sought after.  If you are having trouble coping with life, please don\'t hesitate to contact a medical professional.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xffECECEC),
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
                        child: Text(
                          '     Mood Traxx uses ambient sounds and powerful visualizations to help you cope with stress, depression and anxiety. Setting yourself daily sessions, will help reframe your thinking, using positive affirmations and stimulating visuals, helping you reach new levels of calm throughout the day, every day. You can also listen to any sound at any time, to relax, meditate or as a welcome distraction from worry or negative thoughts. If you need some help falling asleep, try the Sleep Time category. All of our video and audio tracks play in a loop.  The unique and innovative video design allows you to approach your own personal needs in a holistic way and the wide variety of natural sounds means that there\'s something for everyone in this inspiring app.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xffECECEC),
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Text(
                  "Keep Up To Date",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xff141414),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: const Color(0xffECECEC),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(15, 8, 15, 0),
                        child: Text(
                          'Keep up to date and follow us on all of our social media platforms.  Feedback is very welcome and please let us know of additional features or content you would like to see on Mood Traxx.  I look forward to having you as part of the Mood Traxx community!',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xffECECEC),
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              if (!await launch(facebookUrl)) {
                                throw 'Could not launch $facebookUrl';
                              }
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 20, 10, 10),
                              child: Image.asset(
                                'assets/icons/facebook.png',
                                width: 40,
                                height: 40,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (!await launch(instagramUrl)) {
                                throw 'Could not launch $instagramUrl';
                              }
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 20, 10, 10),
                              child: Image.asset(
                                'assets/icons/instagram.png',
                                width: 40,
                                height: 40,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (!await launch(twitterUrl)) {
                                throw 'Could not launch $twitterUrl';
                              }
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 20, 10, 10),
                              child: Image.asset(
                                'assets/icons/twitter.png',
                                width: 40,
                                height: 40,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (!await launch(youtubeUrl)) {
                                throw 'Could not launch $youtubeUrl';
                              }
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 20, 10, 10),
                              child: Image.asset(
                                'assets/icons/youtube.png',
                                width: 40,
                                height: 40,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (!await launch(tiktokUrl)) {
                                throw 'Could not launch $tiktokUrl';
                              }
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 20, 10, 10),
                              child: Image.asset(
                                'assets/icons/tiktok.png',
                                width: 40,
                                height: 40,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(20, 15, 20, 10),
                        child: Divider(
                          thickness: 1,
                          color: Colors.white54,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (!await launch(privacyUrl)) {
                            throw 'Could not launch $privacyUrl';
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Color(0xff1D1D1D),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  'Privacy Policy',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xffECECEC),
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (!await launch(termsUrl)) {
                            throw 'Could not launch $termsUrl';
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Color(0xff1D1D1D),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  'Terms & Conditions',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xffECECEC),
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (!await launch(websiteUrl)) {
                            throw 'Could not launch $websiteUrl';
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                          child: Text(
                            "Mood Traxx Online",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Image.asset(
                          'assets/icons/earth.png',
                          width: 35,
                          height: 35,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text(
                          "www.MoodTraxx.com",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 24, 0, 20),
                child: TextButton(
                  onPressed: () {
                    context.read<AuthenticationHelper>().signOut();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OnboardingScreen()));
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0x7d1a1351),
                    fixedSize: const Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      side:
                          const BorderSide(color: Colors.blueAccent, width: 2),
                    ),
                  ),
                  child: const Text(
                    "Logout",
                    style: TextStyle(color: Colors.white, fontSize: 20),
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
