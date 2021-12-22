import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({ Key? key }) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Register User"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              
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
                        border: OutlineInputBorder(),
                      ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _passController,
                keyboardType: TextInputType.visiblePassword,
                textAlign: TextAlign.center,
                onChanged: (newText) {
                  password = _passController.text;
                },
                decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: "Enter Patient's password",
                        border: OutlineInputBorder(),
                      ),
              ),

              ElevatedButton(
              child:const  Text('Sign Up'),
              onPressed: () async {

                  print('Sign Up Successfully');
                
              },
            ),
            ],
          ),
        ),
      ),
      
    );
  }
}