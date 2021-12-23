import 'package:flutter/material.dart';
// import 'package:form_field_validator/form_field_validator.dart';

const kPrimary = Color(0xFF5856d6);
const primaryColor = Color(0xFF255ED6);
const textColor = Color(0xFF35364F);
const backgroundColor = Color(0xFFE6EFF9);
const redColor = Color(0xFFE85050);
const appBgColor = Color(0xFFFAFAFA);

const defaultPadding = 16.0;

OutlineInputBorder textFieldBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: primaryColor.withOpacity(0.1),
  ),
);

// I will explain it later

const emailError = 'Enter a valid email address';
const requiredField = "This field is required";

// final passwordValidator = MultiValidator(
//   [
//     RequiredValidator(errorText: 'password is required'),
//     MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
//     PatternValidator(r'(?=.*?[#?!@$%^&*-])',
//         errorText: 'passwords must have at least one special character')
//   ],
// );

String baseApi = 'http://phr21.herokuapp.com/api/v1/patient-accounts/login/';
String Api = 'http://phr21.herokuapp.com/api/v1/';

String target_UrlProfile = 'patient-accounts/me/profile/';
String target_Appointment = 'appointments/';

const kPopupTextStyle = TextStyle(
  fontSize: 20.0,
  color: Colors.blue,
);


