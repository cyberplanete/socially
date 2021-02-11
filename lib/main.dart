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

      builder: (BuildContext context, snapshot) {
        print(snapshot);

        /// Si le snapshot de mon stream hasdata, je redirige l'utilisateur vers mainAppController,dans le cas contraire vers SigninController
        return (!snapshot.hasData)
            ? SigninController()
            : MainAppController(uid: snapshot.data.uid);
      },
    );
  }
}
