import 'package:flutter/material.dart';
import '../../util/colors.dart';

class OnboardingPage3 extends StatelessWidget {
  const OnboardingPage3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/TropicalIsland.png',
          // width: 300,
          height: 300,
          fit: BoxFit.fitWidth,
        ),
        const Padding(
          padding:  EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Text(
            'New Content Monthly',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Lexend Deca',
              color: secondaryColor,
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
                  'We keep things fresh!  We upload new experiences & content, every month.\nLogin to your wellness destination.',
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
