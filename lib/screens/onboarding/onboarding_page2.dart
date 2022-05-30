import 'package:flutter/material.dart';
import '../../util/colors.dart';

class OnboardingPage2 extends StatelessWidget {
  const OnboardingPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/zazzhands.gif',
          width: 250,
          height: 250,
          fit: BoxFit.fitWidth,
        ),
        const Text(
          'Mood Tracker',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Lexend Deca',
            color: secondaryColor,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 8),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: const [
              Expanded(
                child: Text(
                  'Log your daily journey & track your destination to a better you!  Our mood tracker is always FREE! For life!\n *All tracker info is stored on your own device.  Never in the cloud.',
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
      ],
    );
  }
}
