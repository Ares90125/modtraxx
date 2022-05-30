import 'package:flutter/material.dart';
import './login.dart';

class CheckEmailScreen extends StatefulWidget {
  const CheckEmailScreen({Key? key}) : super(key: key);

  @override
  _CheckEmailScreenState createState() => _CheckEmailScreenState();
}

class _CheckEmailScreenState extends State<CheckEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 1,
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: Image.asset(
              'assets/images/Abstract_Black.jpg',
            ).image,
          ),
          shape: BoxShape.rectangle,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 80, 0, 60),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/MoodTraxx-Logo-Light.png',
                      width: 240,
                      height: 160,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Icon(
                    Icons.mark_email_read_outlined,
                    color: Colors.white,
                    size: 100,
                  ),
                ),
              ),
              const SizedBox(
                width: 300,
                height: 80,
                child: Text(
                  'Please check your email.  Instructions for password reset, have been sent to your provided email address.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black,
                    fixedSize: const Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      side:
                          const BorderSide(color: Colors.blueAccent, width: 2),
                    ),
                  ),
                  child: const Text(
                    "Back to Login",
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
