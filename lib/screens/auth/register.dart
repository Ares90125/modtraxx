import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:moodtraxx/components/loading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../service/authentication.dart';
import '../homepage/home_page.dart';
import '../../util/colors.dart';
import './login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailAddressfieldController = TextEditingController();
  TextEditingController passwordfieldController = TextEditingController();
  TextEditingController confirmpasswordfieldController =
      TextEditingController();
  bool passwordfieldVisibility = false;
  bool confirmpasswordfieldVisibility = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  void signUp(String email, String password, String confirmpassword) async {
    if (password == confirmpassword) {
      final SharedPreferences _prefs = await SharedPreferences.getInstance();
      context.read<AuthenticationHelper>()
          .signUp(email: email, password: password)
          .then((result) {
        if (result == 'success') {
          setState(() {
            isLoading = false;
          });
          _prefs.setString('mood', json.encode([]));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePageScreen(),
            ),
          );
        } else {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Text(
                result,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ));
        }
      });
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
          child: Text(
            "Password not matching!",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ));
    }
  }

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
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Stack(children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              reverse: true,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 80, 0, 50),
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
                  const Text(
                    'SIGN UP',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                    child: TextFormField(
                      controller: emailAddressfieldController,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        labelStyle: const TextStyle(
                          fontFamily: 'Lexend Deca',
                          color: Color(0x98FFFFFF),
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        hintText: 'Enter your email...',
                        hintStyle: const TextStyle(
                          fontFamily: 'Lexend Deca',
                          color: Color(0x98FFFFFF),
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
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
                        fillColor: const Color(0xAF3124A1),
                        contentPadding: const EdgeInsetsDirectional.fromSTEB(
                            20, 24, 20, 24),
                      ),
                      style: const TextStyle(
                        fontFamily: 'Lexend Deca',
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(20, 12, 20, 0),
                    child: TextFormField(
                      controller: passwordfieldController,
                      obscureText: !passwordfieldVisibility,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: const TextStyle(
                          fontFamily: 'Lexend Deca',
                          color: Color(0x98FFFFFF),
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        hintText: 'Enter your password...',
                        hintStyle: const TextStyle(
                          fontFamily: 'Lexend Deca',
                          color: Color(0x98FFFFFF),
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
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
                        fillColor: const Color(0xAF3124A1),
                        contentPadding: const EdgeInsetsDirectional.fromSTEB(
                            20, 24, 20, 24),
                        suffixIcon: InkWell(
                          onTap: () => setState(
                            () => passwordfieldVisibility =
                                !passwordfieldVisibility,
                          ),
                          child: Icon(
                            passwordfieldVisibility
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: const Color(0x98FFFFFF),
                            size: 20,
                          ),
                        ),
                      ),
                      style: const TextStyle(
                        fontFamily: 'Lexend Deca',
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                    child: TextFormField(
                      controller: confirmpasswordfieldController,
                      obscureText: !confirmpasswordfieldVisibility,
                      decoration: InputDecoration(
                        labelText: 'Confirm password',
                        labelStyle: const TextStyle(
                          fontFamily: 'Lexend Deca',
                          color: Color(0x98FFFFFF),
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        hintText: 'Confirm Password',
                        hintStyle: const TextStyle(
                          fontFamily: 'Lexend Deca',
                          color: Color(0x98FFFFFF),
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
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
                        fillColor: const Color(0xAF3124A1),
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 24, 20, 24),
                        suffixIcon: InkWell(
                          onTap: () => setState(
                            () => confirmpasswordfieldVisibility =
                                !confirmpasswordfieldVisibility,
                          ),
                          child: Icon(
                            confirmpasswordfieldVisibility
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: const Color(0x98FFFFFF),
                            size: 20,
                          ),
                        ),
                      ),
                      style: const TextStyle(
                        fontFamily: 'Lexend Deca',
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        0, 24, 0, MediaQuery.of(context).viewInsets.bottom),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          isLoading = true;
                        });
                        signUp(
                            emailAddressfieldController.text,
                            passwordfieldController.text,
                            confirmpasswordfieldController.text);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.black,
                        fixedSize: const Size(200, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: const BorderSide(
                              color: Colors.blueAccent, width: 2),
                        ),
                      ),
                      child: const Text(
                        "Create Account",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            child: Text(
                              'Already have an account?',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: secondaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(9, 0, 0, 0),
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Lexend Deca',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            isLoading
                ? Center(child: kLoadingWaveWidget(context, Colors.white))
                : Stack(),
          ]),
        ),
      ),
    );
  }
}
