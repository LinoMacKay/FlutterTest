import 'package:flutter/material.dart';
import 'package:test/providers/authenticationProvider.dart';
import 'package:test/utils/routes.dart';
import 'package:test/utils/utils.dart';

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
            onPressed: () async {
              var resp =
                  await Authentication.signInWithGoogle(context: context);
              if (resp!.uid.isNotEmpty) {
                Utils.mainNavigator.currentState!
                    .pushReplacementNamed(routeMovieList);
              }
            },
            child: Text("Inciar Sesion")),
      ),
    );
  }
}
