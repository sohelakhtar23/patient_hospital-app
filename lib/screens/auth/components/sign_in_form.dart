import 'package:flutter/material.dart';


import '../../../constants.dart';
import 'sign_up_form.dart';

import 'package:hospital_ui/log_in_helper.dart';

class SignInForm extends StatefulWidget {
  SignInForm({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  final GlobalKey formKey;

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  late String _email, _password;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  String email = '';
  String password = '';
  

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFieldName(text: "Email"),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(hintText: "test@email.com"),
            
            onChanged: (newText) {
                  email = _emailController.text;
                },
            
          ),
          const SizedBox(height: defaultPadding),
          TextFieldName(text: "Password"),
          TextFormField(
            // We want to hide our password
            obscureText: true,
            controller: _passController,
            decoration: InputDecoration(hintText: "******"),
            
            onChanged: (newText) {
                  password = _passController.text;
                },
          ),
          const SizedBox(height: defaultPadding),
          SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          
Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CheckUser(email: email, password: password,)));
                          
                        },
                        child: Text("Sign In"),
                      ),
                    ),
        ],
      ),
    );
  }
}
