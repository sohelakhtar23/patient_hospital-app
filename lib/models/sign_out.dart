import 'package:flutter/material.dart';
import 'package:hospital_ui/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hospital_ui/screens/welcome/welcome_screen.dart';

class SignOut extends StatelessWidget {
  const SignOut({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () async {
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool('login', true);
          // prefs.setString('username', 'User');
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const WelcomeScreen()));
        },
        child: const Text('Sign Out'),
        style: ElevatedButton.styleFrom(
          primary: kPrimary,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                  ),
      ),
    );
  }
}
