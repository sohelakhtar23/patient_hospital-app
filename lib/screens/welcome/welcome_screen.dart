import 'package:hospital_ui/constants.dart';
import 'package:hospital_ui/screens/auth/sign_in_screen.dart';
import 'package:hospital_ui/screens/auth/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:hospital_ui/homepage.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late bool newuser;
  @override
  void initState() {
    super.initState();
    check_if_already_login();
  }

  void check_if_already_login() async {
    final prefs = await SharedPreferences.getInstance();
    newuser = (prefs.getBool('login') ?? true);
    String loggedUser = (prefs.getString('username') ?? '');

    print('$newuser, $loggedUser ');
    if (newuser == false) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset("assets/icons/splash_bg.svg"),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                children: [
                  Spacer(),
                  // SvgPicture.asset(
                  //   "assets/icons/gerda_logo.svg",
                  // ),

                  const Text(
                    'Medico',
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Spacer(),
                  // As you can see we need more paddind on our btn
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xFF6CD8D1),
                      ),
                      child: Text("Sign Up"),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: defaultPadding),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignInScreen(),
                            )),
                        style: TextButton.styleFrom(
                          // backgroundColor: Color(0xFF6CD8D1),
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Color(0xFF6CD8D1)),
                          ),
                        ),
                        child: Text("Sign In"),
                      ),
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
