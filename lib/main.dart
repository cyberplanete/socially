import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:socially/controllers/main_app_Controller.dart';
import 'package:socially/controllers/signin_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Firebase.initializeApp()
      .whenComplete(() => print('Initialisation Firebase Complete'));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Socially',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: _isUserConnected(),
    );
  }

  Widget _isUserConnected() {
    return StreamBuilder<User>(
      ///S'abonner au stream changement d'authentification pour observer les informations de connections: signin signout
      stream: FirebaseAuth.instance.authStateChanges(),

      /// Ces informations sont utilisées dans mon constructeur- Si il y a pas de donnée d'un utilisateur connecté alors je dirige l'utilisateur vers SigninController
      builder: (BuildContext context, snapshot) {
        return (!snapshot.hasData) ? SigninController() : MainAppController();
      },
    );
  }
}
