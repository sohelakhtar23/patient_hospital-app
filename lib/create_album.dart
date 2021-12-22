import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> createAlbum(String title) async {
  
  final response;
  try {
    response = await http.post(
      // Uri.parse('https://jsonplaceholder.typicode.com/albums'),
      Uri.parse(
          'https://blog-api7991.herokuapp.com/blog-api/accounts/user_login/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        // 'title': title,
        'username': "user1", 'password': "string123"
      }),
    );
  } catch (e) {
    print('Some Error');
    throw Exception('Some Error occurred.');
  }

  print('Below http request');
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print('Response successfully');
    print(response.body);
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    print('Response Error');
    throw Exception('Failed to create album.');
  }
}

class Album {
  // final int id;
  // final String title;
  final String username;
  final String password;

  // Album({required this.id, required this.title});
  Album({required this.username, required this.password});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      // id: json['id'],
      // title: json['title'],

      username: json['username'],
      password: json['password'],
    );
  }
}

class PostAlbum extends StatefulWidget {
  const PostAlbum({Key? key}) : super(key: key);

  @override
  _PostAlbumState createState() => _PostAlbumState();
}

class _PostAlbumState extends State<PostAlbum> {
  final TextEditingController _controller = TextEditingController();
  Future<Album>? _futureAlbum;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Create Data Example'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: (_futureAlbum == null) ? buildColumn() : buildFutureBuilder(),
        ),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _controller,
          decoration: const InputDecoration(hintText: 'Enter Title'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _futureAlbum = createAlbum(_controller.text);
            });
          },
          child: const Text('Create Data'),
        ),
      ],
    );
  }

  FutureBuilder<Album> buildFutureBuilder() {
    return FutureBuilder<Album>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.username);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
