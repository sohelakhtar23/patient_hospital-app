import 'package:flutter/material.dart';
import 'package:hospital_ui/create_album.dart';
import 'package:hospital_ui/fetch_data.dart';
import 'package:hospital_ui/homepage.dart';
import 'package:hospital_ui/log_in_helper.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:hospital_ui/screens/welcome/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Medico',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const LogSignUp(),
      home: const WelcomeScreen(),
    );
  }
}

class LogSignUp extends StatefulWidget {
  const LogSignUp({Key? key}) : super(key: key);

  @override
  _LogSignUpState createState() => _LogSignUpState();
}

class _LogSignUpState extends State<LogSignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  String email = '';
  String password = '';
  

  
  late bool newuser;
  @override
  void initState() {
    super.initState();
    check_if_already_login();
  }

  void check_if_already_login() async {
    final prefs = await SharedPreferences.getInstance();
    newuser = (prefs.getBool('login') ?? true);
    String loggedUser = (prefs.getString('token') ?? '');
    
    print('$newuser, $loggedUser ');
    if (newuser == false) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log In / Sign Up'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (newText) {
                  email = _emailController.text;
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: "Enter Patient's email",
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _passController,
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (newText) {
                  password = _passController.text;
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  hintText: "Enter Patient's password",
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              ElevatedButton(
                child: const Text('Login'),
                onPressed: ()  {
                  
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CheckUser(email: email, password: password,)));
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PostAlbum()));
                  },
                  child: const Text('Sign Up')),
            ],
          ),
        ),
      ),
    );
  }
}
