import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socially/controllers/fireStoreController.dart';
import 'package:socially/models/post.dart';
import 'package:socially/models/utilisateurs.dart';
import 'package:socially/views/Tuiles/post_tuile.dart';
import 'package:socially/views/my_material.dart';

class PageFilActualite extends StatefulWidget {
  String utilisateurID;
  PageFilActualite({this.utilisateurID});

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
    super.initState();
    configurationStreamSubscription();
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext buildContext, bool isScrolled) {
        // Je retourne  un array
        return [MySliverAppBar(titre: "Fil d'actualité", image: cImageHome)];
      },
      body: ListView.builder(
        itemCount: listPosts.length,
        itemBuilder: (BuildContext buildContext, int index) {
          Post post = listPosts[index];
          Utilisateur utilisateur = listUtilisateurs.singleWhere(
              (utilisateurID) => utilisateurID.uid == post.utilisateurUID);
          return PostTuile(
            post: post,
            utilisateur: utilisateur,
            isPageDetail: false,
          );
        },
      ),
    );
  }

  ///Afficher la liste de posts des abonnes suivant l'utilisateur connecté -

  configurationStreamSubscription() {
    // Ecouter les snapshots des abonnes de l'utilisateur connecté
    streamSubscription = FireStoreController()
        .fireStore_collectionUtilisateurs
        .where(cKeyAbonnes, arrayContains: widget.utilisateurID)
        .snapshots()
        .listen((datas) {
      //getUtilisateurs cree une liste d'utilisateurs
      getUtilisateurs(datas.docs);
      //Pour chaque utilisateur j'ecoute leurs posts snapshots
      datas.docs.forEach((docs) {
        docs.reference
            .collection("posts")
            .snapshots()
            .listen((listPostsSnapshot) {
          setState(() {
            //getPosts crée une liste de posts
            listPosts = getPosts(listPostsSnapshot.docs);
          });
        });
      });
    });
  }

  /// Methode traitant la listUtilisateurSnapshot de chaque utilisateur.
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
    });
    setState(() {
      listUtilisateurs = myListUtilisateur;
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
    });
    //Trie de ma liste en fonction de la date
    myListPosts.sort((a, b) => b.date.compareTo(a.date));
    return myListPosts;
  }
}
