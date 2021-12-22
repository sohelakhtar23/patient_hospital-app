import 'package:flutter/material.dart';
import 'package:hospital_ui/models/make_appointment.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
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
              SizedBox(height: 100,),
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
              
              SizedBox(height: 40,),
              const Text(
                'Past Appointments',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Divider(color: Colors.black38),
              
              ListView.builder(
                  itemCount: 5,
                   shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, i) {
                    return ListTile(title: Text('Appointment $i'));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
