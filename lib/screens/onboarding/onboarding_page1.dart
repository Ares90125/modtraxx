import 'package:flutter/material.dart';

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/Smoke_Reveal.gif',
          // width: 300,
          height: 300,
          fit: BoxFit.fitWidth,
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Text(
            'Clear Your Mind',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Lexend Deca',
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 8),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: const [
              Expanded(
                child: Text(
                  'We offer Soundscapes with beautiful cinematic scenery, Meditation, Spatial & Ambionic Audio, Virtual Reality & more!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Lexend Deca',
                    color: Color(0x99FFFFFF),
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Text(
          '*Swipe To See More*',
          textAlign: TextAlign.center,
          style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w300,
                color: Colors.blueAccent
              ),
        ),
      ],
    );
  }
}
