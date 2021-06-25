import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:socially/controllers/fireStoreController.dart';
import 'package:socially/models/commentaire.dart';
import 'package:socially/models/utilisateurs.dart';
import 'package:socially/views/my_material.dart';

class CommentTuile extends StatelessWidget {
  Commentaire commentaire;

  CommentTuile({this.commentaire});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      builder: (BuildContext buildContext,
          AsyncSnapshot<DocumentSnapshot> asyncSnapshot) {
        if (asyncSnapshot.hasData) {
          Utilisateur utilisateur = Utilisateur(asyncSnapshot.data);
          return Container(
            color: cColorWhite,
            margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 2.5),
            padding: EdgeInsets.all(5.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        MyProfileImage(
                          //TODO Renvoyer vers detail utilisateur
                          onPressed: null,
                          urlString: utilisateur.imageUrl, taille: 15.0,
                        ),
                        MyText(
                          dataText: "${utilisateur.nom} ${utilisateur.prenom}",
                        )
                      ],
                    ),
                    MyText(
                      dataText: commentaire.date,
                      color: cColorPointer,
                    )
                  ],
                ),
                MyText(
                  dataText: commentaire.texte,
                  color: cColorBaseAccent,
                )
              ],
            ),
          );
        } else {
          return Container();
        }
      },
      stream: FireStoreController()
          .fireStore_collectionUtilisateurs
          .doc(commentaire.utilisateurUID)
          .snapshots(),
    );
  }
}
