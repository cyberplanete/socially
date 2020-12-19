import 'package:flutter/material.dart';

class MainAppController extends StatefulWidget {
  _StateMainAppController createState() => _StateMainAppController();
}

class _StateMainAppController extends State<MainAppController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Text(
        'Another test',
        style: TextStyle(color: Colors.red),
      ),
    );
  }
}
