import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hospital_ui/models/sign_out.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hospital_ui/constants.dart';




class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String final_Url = Api + target_UrlProfile;
  bool _profileLoaded = false;
  dynamic responseJson;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(final_Url);
    getProfile(final_Url);
  }

  void getProfile(String url) async {
    final prefs = await SharedPreferences.getInstance();
    final response;
    String token = prefs.getString('token') ?? '';

    // String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InVzZXJAZXhhbXBsZS5jb20iLCJleHAiOjE2NDAyMDE5MzF9.MTkr35cGQhlb6GAIYIvmzqU0_d85nYWIa-a4YD6NRdQ';
    // print(token);

    try {
      response = await http.get(
        Uri.parse(url),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );
      responseJson = jsonDecode(response.body);
      setState(() {
        _profileLoaded = true;
      });
      print(responseJson);
    } catch (e) {
      print('Some Error-Profile Page : $e');
      throw Exception('Some Error occurred.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        backgroundColor: Color.fromRGBO(255, 255, 255, .9),
        body: (_profileLoaded == false)
            ? Center(child: CircularProgressIndicator())
            : SafeArea(
                child: ListView(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: 330,
                          color: Colors.deepPurple,
                        ),
                        Positioned(
                          top: 10,
                          right: 30,
                          child: Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                                height: 90,
                                margin: EdgeInsets.only(top: 60),
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.white,
                                  // child: PNetworkImage(rocket),
                                )),
                            Padding(
                              padding: EdgeInsets.all(4),
                            ),
                            Text(
                              responseJson['full_name'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                            Padding(
                              padding: EdgeInsets.all(4),
                            ),
                            UserInfo(responseJson),

                            SignOut(),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ));
  }
}

class UserInfo extends StatelessWidget {
  dynamic responseJson;
  UserInfo(this.responseJson);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Card(
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "User Information",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Divider(
                    color: Colors.black38,
                  ),
                  Container(
                      child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.email),
                        title: Text("Email"),
                        subtitle: Text(responseJson['email']),
                      ),
                      ListTile(
                        leading: Icon(Icons.phone),
                        title: Text("Phone"),
                        subtitle: Text(responseJson['contact_no']),
                      ),
                      ListTile(
                        leading: Icon(Icons.person),
                        title: Text("Gender"),
                        subtitle: Text(responseJson['gender']),
                      ),
                      ListTile(
                        leading: Icon(Icons.date_range),
                        title: Text("DOB"),
                        subtitle: Text(responseJson['date_of_birth']),
                      ),
                      ListTile(
                        leading: Icon(Icons.bloodtype),
                        title: Text("Blood Group"),
                        subtitle: Text(responseJson['blood_group']),
                      ),
                    ],
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
