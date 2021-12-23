// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:hospital_ui/models/make_appointment.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hospital_ui/constants.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  String final_Url = Api + target_Appointment;
  bool _profileLoaded = false;
  dynamic responseJson;

  late Future<PhotosList> photosList;
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(final_Url);
    photosList= getProfile(final_Url);
  }

  Future<PhotosList> getProfile(String url) async {
    final prefs = await SharedPreferences.getInstance();
    final response;
    String token = prefs.getString('token') ?? '';

    // String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InVzZXJAZXhhbXBsZS5jb20iLCJleHAiOjE2NDAyMDE5MzF9.MTkr35cGQhlb6GAIYIvmzqU0_d85nYWIa-a4YD6NRdQ';
    // print(token);

    try {
      response = await http.get(
        Uri.parse(url),
        // headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );
      responseJson = jsonDecode(response.body);
      setState(() {
        _profileLoaded = true;
      });
      print(responseJson);
      return PhotosList.fromJson(responseJson);
      
    } catch (e) {
      print('Some Error-Profile Page : $e');
      throw Exception('Some Error occurred.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 100,
              ),
              ElevatedButton(
                onPressed: () async {
                  await showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: AddAppointment(),
                      ),
                    ),
                  );
                },
                child: const Text('Make an Appointment'),
                style: ElevatedButton.styleFrom(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                ),
              ),

              SizedBox(
                height: 40,
              ),
              const Text(
                'Past Appointments',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Divider(color: Colors.black38),

              // ListView.builder(
              //     itemCount: 5,
              //      shrinkWrap: true,
              //       physics: NeverScrollableScrollPhysics(),
              //     itemBuilder: (context, i) {
              //       return ListTile(title: Text('Appointment $i'));
              //     })

              Center(
                child: FutureBuilder<PhotosList>(
                  future: photosList,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('An error has occurred!'),
                      );
                    } else if (snapshot.hasData) {
                      return AppointmentList(photos: snapshot.data!);
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





class AppointmentList extends StatelessWidget {
  const AppointmentList({Key? key, required this.photos}) : super(key: key);

  final PhotosList photos;
  

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: photos.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        print('photo = ${photos.allPhotos[index].schedule_date}');
        // return ListView(
        //   children: [
        //     // Text('${photos[index].is_approve}'),
        //     Text(photos.allPhotos[index].schedule_date),
        //     Text(photos.allPhotos[index].description),
        //     // Text(photos[index].doctor),
        //   ],
        // );
        return Text('$index');
      },
    );
  }
}



class Photo {
  // final int albumId;
  // final int id;
  final String? schedule_date;
  final String? description;
  // final String thumbnailUrl;

  const Photo({
    required this.schedule_date,
    required this.description,
    // required this.title,
    // required this.url,
    // required this.thumbnailUrl,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      // albumId: json['albumId'] as int,
      // id: json['id'] as int,
      schedule_date: json['schedule_date'],
      description: json['description'] ,
      // thumbnailUrl: json['thumbnailUrl'] as String,
    );
  }

  
}


class PhotosList {
  final List<Photo> photos;

  PhotosList({
    required this.photos,
  });

  int get length => photos.length;

  List<Photo> get allPhotos => photos;

  factory PhotosList.fromJson(List<dynamic> parsedJson) {

    List<Photo> photos = [];
    photos = parsedJson.map((i)=>Photo.fromJson(i)).toList();

    return new PhotosList(
      photos: photos
    );
  }
}