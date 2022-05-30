import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './register.dart';
import './reset_password.dart';
import '../homepage/home_page.dart';
import '../../service/authentication.dart';
import '../../components/loading.dart';
import '../../util/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  TextEditingController emailAddressfieldController = TextEditingController();
  TextEditingController passwordfieldController = TextEditingController();
  bool passwordfieldVisibility = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _focusNode1.dispose();
    _focusNode2.dispose();

    super.dispose();
  }

  void signIn(String email, String password) {
    context.read<AuthenticationHelper>()
        .signIn(email: email, password: password)
        .then((result) {
      if (result == 'success') {
        setState(() {
          isLoading = false;
        });
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomePageScreen()));
      } else {
        setState(() {
          isLoading = false;
        });
        if (result != null) {
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
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
                    'LOGIN',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TextFormField(
                      controller: emailAddressfieldController,
                      focusNode: _focusNode1,
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
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 24, 20, 24),
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
                      controller: passwordfieldController,
                      obscureText: !passwordfieldVisibility,
                      focusNode: _focusNode2,
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
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 24, 20, 24),
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
                    padding: EdgeInsets.fromLTRB(
                        0, 24, 0, MediaQuery.of(context).viewInsets.bottom),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          isLoading = true;
                        });
                        signIn(emailAddressfieldController.text,
                            passwordfieldController.text);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0x7d1a1351),
                        fixedSize: const Size(200, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: const BorderSide(
                              color: Colors.blueAccent, width: 2),
                        ),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ResetPasswordScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Lexend Deca',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Text(
                            'Don\'t have an account yet? :',
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
                                  builder: (context) => const RegisterScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              "Register",
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
