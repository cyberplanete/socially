import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socially/models/utilisateurs.dart';
import 'package:socially/views/my_material.dart';

class PageFilActualite extends StatefulWidget {
  Utilisateur utilisateur;
  PageFilActualite({this.utilisateur});

  @override
  _PageFilActualiteState createState() => _PageFilActualiteState();
}

class _PageFilActualiteState extends State<PageFilActualite> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MyText(
        dataText: "Page Fil Actualite",
      ),
    );
  }
}
