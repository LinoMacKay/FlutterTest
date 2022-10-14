import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/providers/notificationProvider.dart';
import 'package:test/utils/utils.dart';

class Authentication {
  static Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    // TODO: Add auto login logic

    return firebaseApp;
  }

  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    initializeFirebase();
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    final prefs = await SharedPreferences.getInstance();

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
        prefs.setString("id", user!.uid.toString());
        NotificationProvider()
            .showSnackbar(context, "Logeado Correctamente", "success", null);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          NotificationProvider()
              .showSnackbar(context, "Su cuenta ya existe", "error", null);
        } else if (e.code == 'invalid-credential') {
          NotificationProvider()
              .showSnackbar(context, "Credenciales Incorrectas", "error", null);
        }
      } catch (e) {
        // handle the error here
      }
    }

    return user;
  }
}
