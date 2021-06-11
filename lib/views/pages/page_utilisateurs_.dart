import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socially/controllers/fireStoreController.dart';
import 'package:socially/models/utilisateurs.dart';
import 'package:socially/views/Tuiles/listeUtilisateurTuile.dart';
import 'package:socially/views/my_material.dart';
import 'package:socially/views/my_widgets/my_loading_Center.dart';

class PageUtilisateurs extends StatefulWidget {
  Utilisateur utilisateur;
  PageUtilisateurs({this.utilisateur});
  _PageUtilisateur createState() => _PageUtilisateur();
}

class _PageUtilisateur extends State<PageUtilisateurs> {
  @override
  Widget build(BuildContext context) {
    //Construction de la liste des utilisateurs avec un streamBuilder
    //StreamBuilder écoute le Stream utilisateur, chaque fois que certaines données sortent de ce Stream, il se reconstruit automatiquement, appelant son callback builder.
    return StreamBuilder<QuerySnapshot>(
      builder:
          (BuildContext buicontext, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List<DocumentSnapshot> listOfUser = snapshot.data.docs;
          return NestedScrollView(
            headerSliverBuilder: (BuildContext buildContext, bool isScrolled) {
              // Je retourne  un array
              return [
                SliverAppBar(
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: MyText(
                      dataText: "Liste d'utilisateurs",
                      color: cBaseAccent,
                    ),
                    background: Image(
                      image: cEventImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                  expandedHeight: 150.0,
                )
              ];
            },
            //Construction de ma liste
            body: ListView.builder(
                itemCount: listOfUser.length,
                itemBuilder: (BuildContext buildContext, int index) {
                  Utilisateur utilisateur = Utilisateur(listOfUser[index]);
                  return UtilisateurTuile(
                    utilisateur: utilisateur,
                  );
                }),
          );
        } else {
          return LoadingCenter();
        }
      },
      stream: FireStoreController().fireStore_collectionOfUSers.snapshots(),
    );
  }
}
