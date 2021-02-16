import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socially/models/utilisateurs.dart';
import 'package:socially/views/my_material.dart';

class PageProfil extends StatefulWidget {
  Utilisateur utilisateur;
  PageProfil({this.utilisateur});

  _PageProfilState createState() => _PageProfilState();
}

class _PageProfilState extends State<PageProfil> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MyTextButton(dataText: "Page Profil:"),
    );
  }
}
