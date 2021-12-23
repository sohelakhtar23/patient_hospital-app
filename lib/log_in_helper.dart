import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hospital_ui/constants.dart';
import 'package:hospital_ui/homepage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginHelper {
  final String username;
  final String password;

  LoginHelper({required this.username, required this.password});

  factory LoginHelper.fromJson(Map<String, dynamic> json) {
    return LoginHelper(
      username: json['username'],
      password: json['password'],
    );
  }
}

class CheckUser extends StatefulWidget {
  String? email;
  String? password;
  CheckUser({required this.email, this.password});
  @override
  _CheckUserState createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  SharedPreferences? logindata;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginUser(widget.email!, widget.password!);
  }

  void loginUser(String name, String pass) async {
    final response;
    try {
      response = await http.post(
        Uri.parse(baseApi),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'email': name, 'password': pass}),
      );
    } catch (e) {
      print('Some Error');
      Navigator.pop(context);
      throw Exception('Some Error occurred.');
    }

    // print('Below http request');
    if (response.statusCode == 200) {
      print('Response Login successfully');
      print(response.body);
      Navigator.pop(context);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Home()));

      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('login', false);

      // logindata!.setBool('login', false);
      print('login --> false');
      dynamic resp = jsonDecode(response.body);

      print(resp['token']);
      prefs.setString('token', resp['token']);

      // return LoginHelper.fromJson(jsonDecode(response.body));
    } else {
      print('Response Login Error');
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Log In Failed !',
                style: TextStyle(color: Colors.red)),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Ok'),
              ),
            ],
          );
        },
      );
      throw Exception('Failed to login.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
