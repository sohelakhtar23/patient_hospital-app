import 'package:flutter/material.dart';
// import 'package:form_field_validator/form_field_validator.dart';

import '../../../constants.dart';

class SignUpForm extends StatelessWidget {
  SignUpForm({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  final GlobalKey formKey;

  late String _userName, _email, _password, _phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFieldName(text: "Username"),
          TextFormField(
            // decoration: InputDecoration(hintText: "theflutterway"),

            // Let's save our username
            onSaved: (username) => _userName = username!,
          ),
          const SizedBox(height: defaultPadding),
          // We will fixed the error soon
          // As you can see, it's a email field
          // But no @ on keybord
          TextFieldName(text: "Email"),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(hintText: "test@email.com"),
            onSaved: (email) => _email = email!,
          ),

          const SizedBox(height: defaultPadding),
          TextFieldName(text: "Password"),

          TextFormField(
            // We want to hide our password
            obscureText: true,
            decoration: InputDecoration(hintText: "******"),

            onSaved: (password) => _password = password!,
            // We also need to validate our password
            // Now if we type anything it adds that to our password
            onChanged: (pass) => _password = pass,
          ),
          const SizedBox(height: defaultPadding),
          // TextFieldName(text: "Confirm Password"),
          // TextFormField(
          //   obscureText: true,
          //   decoration: InputDecoration(hintText: "******"),

          // ),

          const SizedBox(height: defaultPadding),
          TextFieldName(text: "Phone"),
          // Same for phone number
          TextFormField(
            keyboardType: TextInputType.phone,
            // decoration: InputDecoration(hintText: "+123487697"),

            onSaved: (phoneNumber) => _phoneNumber = phoneNumber!,
          ),
          const SizedBox(height: defaultPadding),
          TextFieldName(text: "Gender"),
          // Same for phone number
          TextFormField(
            
            // decoration: InputDecoration(hintText: "+123487697"),
            
            // onSaved: (phoneNumber) => _phoneNumber = phoneNumber!,
          ),
          const SizedBox(height: defaultPadding),
          TextFieldName(text: "Blood Group"),
          // Same for phone number
          TextFormField(
            // keyboardType: TextInputType.phone,
            // decoration: InputDecoration(hintText: "+123487697"),
            
            // onSaved: (phoneNumber) => _phoneNumber = phoneNumber!,
          ),
          const SizedBox(height: defaultPadding),
          TextFieldName(text: "DOB"),
          // Same for phone number
          TextFormField(
            // keyboardType: TextInputType.phone,
            // decoration: InputDecoration(hintText: "+123487697"),
            
            // onSaved: (phoneNumber) => _phoneNumber = phoneNumber!,
          ),
        ],
      ),
    );
  }
}

class TextFieldName extends StatelessWidget {
  const TextFieldName({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding / 3),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black54),
      ),
    );
  }
}
