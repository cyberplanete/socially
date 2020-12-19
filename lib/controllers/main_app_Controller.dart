import 'package:flutter/material.dart';

class MainAppController extends StatefulWidget {
  _StateMainAppController createState() => _StateMainAppController();
}

///Cette page quand l'utilisateur est connecté
class _StateMainAppController extends State<MainAppController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Text(
        'Connected',
        style: TextStyle(color: Colors.red),
      ),
    );
  }
}
