import 'package:flutter/material.dart';
import 'package:socially/controllers/fireStoreController.dart';
import 'package:socially/models/utilisateurs.dart';
import 'package:socially/views/my_material.dart';

class MyButtonTextSuivre extends TextButton {
  MyButtonTextSuivre({@required Utilisateur autreUtilisateur})
      : super(
            child: MyText(
              dataText: cUtilisateurConnecte.abonnementList
                      .contains(autreUtilisateur.uid)
                  ? "Ne plus suivre"
                  : "Suivre",
              color: cPointer,
            ),
            onPressed: () {
              FireStoreController().suivreUtilisateur(autreUtilisateur);
            });
}
