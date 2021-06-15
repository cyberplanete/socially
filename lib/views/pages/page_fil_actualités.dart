import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socially/controllers/fireStoreController.dart';
import 'package:socially/models/post.dart';
import 'package:socially/models/utilisateurs.dart';
import 'package:socially/views/my_material.dart';

class PageFilActualite extends StatefulWidget {
  Utilisateur utilisateur;
  PageFilActualite({this.utilisateur});

  @override
  _PageFilActualiteState createState() => _PageFilActualiteState();
}

class _PageFilActualiteState extends State<PageFilActualite> {
  //Si streamSubscription alors il faut un initState et dispose
  StreamSubscription streamSubscription;
  List<Utilisateur> listUtilisateurs = [];
  List<Post> listPosts = [];

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    configurationStreamSubscription();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext buildContext, bool isScrolled) {
          // Je retourne  un array
          return [MySliverAppBar(titre: "Fil d'actualité", image: cHomeImage)];
        },
        body: MyLoadingCenter());
  }

  ///Afficher la liste de posts des abonnes suivant l'utilisateur connecté -

  void configurationStreamSubscription() {
    // Ecouter les snapshots des abonnes de l'utilisateur connecté
    streamSubscription = FireStoreController()
        .fireStore_collectionOfUSers
        .where(cKeyAbonnes, arrayContains: cUtilisateurConnecte.uid)
        .snapshots()
        .listen((datas) {
      //getUtilisateurs cree une liste d'utilisateurs
      getUtilisateurs(datas.docs);
      //Pour chaque utilisateur j'ecoute leurs snapshots
      datas.docs.forEach((utilisateur) {
        utilisateur.reference
            .collection("post")
            .snapshots()
            .listen((listPostSnapshot) {
          setState(() {
            //getPosts crée une liste de posts
            listPosts = getPosts(listPostSnapshot.docs);
          });
        });
      });
    });
  }

  /// Methode traitant la listUtiliseurSnapshot de chaque utilisateur.
  /// Ajoute un utilisateur dans la liste des utilisateurs si non présent dans la liste
  List<Post> getUtilisateurs(List<DocumentSnapshot> listUtiliseurSnapshot) {
    List<Utilisateur> myListUtilisateur = listUtilisateurs;
    listUtiliseurSnapshot.forEach((utilisateurSnapshot) {
      Utilisateur utilisateur = Utilisateur(utilisateurSnapshot);
      if (myListUtilisateur
          .every((unUtilisateur) => unUtilisateur.uid != utilisateur.uid)) {
        myListUtilisateur.add(utilisateur);
      } //Si utilisateur modifie( ajout d'un like ou commentaire) alors mise à jour de la liste
      else {
        Utilisateur utilisateurAChanger = myListUtilisateur.singleWhere(
            (unUtilisateur) => unUtilisateur.uid == utilisateur.uid);
        myListUtilisateur.remove(utilisateurAChanger);
        myListUtilisateur.add(utilisateur);
      }
      setState(() {
        listUtilisateurs = myListUtilisateur;
      });
    });
  }

  /// Methode traitant la listPostSnapshot de chaque utilisateur
  /// Ajoute un post dans la liste des posts si non présent dans la liste.
  /// Si un post est modifie( ajout d'un like ou commentaire) alors mise à jour de la liste
  List<Post> getPosts(List<DocumentSnapshot> listPostSnapshot) {
    List<Post> myListPosts = listPosts;
    listPostSnapshot.forEach((unPost) {
      Post post = Post(documentSnapshot: unPost);
      //Pour debug
      print("Nouveau document => ${post.texte}");
      //Ajouter un post dans la liste si non présent dans la liste
      if (myListPosts.every((unPost) => unPost.documentID != post.documentID)) {
        myListPosts.add(post);
      } //Si post modifie( ajout d'un like ou commentaire) ou est revenu alors mise à jour de la liste
      else {
        Post postAChanger = myListPosts
            .singleWhere((unPost) => unPost.documentID == post.documentID);
        myListPosts.remove(postAChanger);
        myListPosts.add(post);
      }
      ;
    });
    return myListPosts;
  }
}
