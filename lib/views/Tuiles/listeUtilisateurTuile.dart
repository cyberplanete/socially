import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socially/models/utilisateurs.dart';
import 'package:socially/views/my_widgets/constants.dart';
import 'package:socially/views/my_widgets/my_buttonText_suivre.dart';
import 'package:socially/views/my_widgets/my_profile_image.dart';
import 'package:socially/views/my_widgets/my_text_widget.dart';

class UtilisateurTuile extends StatelessWidget {
  Utilisateur utilisateur;
  UtilisateurTuile({this.utilisateur});
  @override
  Widget build(BuildContext context) {
    //A rectangular area of a Material that responds to touch.
    return InkWell(
      child: Container(
        color: Colors.transparent,
        margin: EdgeInsets.all(2.5),
        child: Card(
          elevation: 5.0,
          child: Container(
            padding: EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Deux rows crée afin d'éviter le decalage du texte utilisateur quand le bouton suivre est utilisé
                Row(
                  children: [
                    MyProfileImage(
                        onPressed: null, urlString: utilisateur.imageUrl),
                    MyText(
                      dataText: "${utilisateur.nom} ${utilisateur.prenom}",
                      color: cBaseAccent,
                    ),
                    //Ne pas pas afficher le bouton suivre si il s'agit du meme utilisateur connecte dans la liste.
                  ],
                ),
                (utilisateur.uid == cUtilisateurConnecte.uid)
                    ? Container(
                        width: 0.0,
                      )
                    : MyButtonTextSuivre(autreUtilisateur: utilisateur)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
