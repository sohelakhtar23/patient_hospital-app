import 'package:flutter/material.dart';
import 'package:hospital_ui/constants.dart';
import 'package:hospital_ui/screens/auth/components/sign_up_form.dart';
// import 'package:attendance_app/models/db_tables.dart';
// import 'package:attendance_app/models/database_helper.dart';

class AddAppointment extends StatefulWidget {
  @override
  _AddAppointmentState createState() => _AddAppointmentState();
}

class _AddAppointmentState extends State<AddAppointment> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _ill_cntrl = TextEditingController();

  String _department = 'One';
  String _doctor = 'A';
  String _ill = '';
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const TextFieldName(text: 'Select Department'),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.blueAccent,
                ),
                dropdownColor: Colors.blueAccent,
                value: _department,
                onChanged: (String? newValue) {
                  setState(() {
                    _department = newValue!;
                  });
                },
                items: <String>['One', 'Two', 'Free', 'Four']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: defaultPadding),
              const TextFieldName(text: 'Select Doctor'),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.blueAccent,
                ),
                dropdownColor: Colors.blueAccent,
                value: _doctor,
                onChanged: (String? newValue) {
                  setState(() {
                    _doctor = newValue!;
                  });
                },
                items: <String>['A', 'B', 'C', 'D']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: defaultPadding),
              Row(
                children: [
                  TextFieldName(text: 'Enter Date'),
                  Spacer(),
                  Text("${selectedDate.toLocal()}".split(' ')[0]),
                  IconButton(
                      onPressed: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate, // Refer step 1
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2025),
                        );
                        if (picked != null && picked != selectedDate)
                          setState(() {
                            selectedDate = picked;
                          });
                      },
                      icon: Icon(Icons.date_range))
                ],
              ),
              const SizedBox(height: defaultPadding),
              TextFieldName(text: 'Describe your illness'),
              TextFormField(
                controller: _ill_cntrl,
                keyboardType: TextInputType.emailAddress,
                onChanged: (newText) {
                  _ill = _ill_cntrl.text;
                },
              ),
              SizedBox(height: 20.0),
              FlatButton(
                color: Colors.blue,
                child: Text('Submit For Approval',
                    style: TextStyle(color: Colors.white)),
                onPressed: () {


                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addClass() async {
    Navigator.pop(context, true);

    // section.days = 0;
    // int result;
    // result = await helper.insertClass(section);
    // if (result != 0) {
    // Success
    _showAlertDialog(
      'Status',
      'Class Added !',
      Colors.green,
    );
    // } else {
    // Failure
    // _showAlertDialog('Status', 'Problem Adding Class', Colors.red);
  }

  void _showAlertDialog(String title, String message, Color clr) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: TextStyle(color: clr)),
          content: Text(message),
          actions: [
            FlatButton(
                onPressed: () => Navigator.pop(context), child: Text('Ok'))
          ],
        );
      },
    );
  }
}
