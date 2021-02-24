import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socially/models/utilisateurs.dart';
import 'package:socially/views/my_material.dart';

class PageUtilisateurs extends StatefulWidget {
  Utilisateur utilisateur;
  PageUtilisateurs({this.utilisateur});
  _PageUtilisateur createState() => _PageUtilisateur();
}

class _PageUtilisateur extends State<PageUtilisateurs> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MyText(
        dataText: "Liste utilisateur",
      ),
    );
  }
}
