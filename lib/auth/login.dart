import 'package:flutter/material.dart';
import 'package:test/providers/authenticationProvider.dart';

class Login extends StatefulWidget {
  Login();

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Authentication.signInWithGoogle(context: context)
                  .then((value) {});
            },
            child: Text("Inciar Sesion")),
      ),
    );
  }
}
