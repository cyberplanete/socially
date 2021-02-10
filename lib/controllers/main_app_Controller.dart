import 'package:flutter/material.dart';
import 'package:socially/views/my_material.dart';
import 'package:socially/views/my_widgets/my_progressBar_scafold.dart';

class MainAppController extends StatefulWidget {
  _StateMainAppController createState() => _StateMainAppController();
}

///Cette page est affiché quand l'utilisateur est connecté
class _StateMainAppController extends State<MainAppController> {
  @override
  Widget build(BuildContext context) {
    return MyProgressScafold();
  }
}
