import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:socially/views/my_material.dart';

class Post {
  DocumentReference documentReference;
  String documentID;
  String postId;
  String texte;
  String utilisateurUID;
  String imageUrl;
  int date;
  List<dynamic> likes = [];
  List<dynamic> commentaires = [];

  Post({DocumentSnapshot documentSnapshot}) {
    documentReference = documentSnapshot.reference;
    documentID = documentSnapshot.id;
    Map<String, dynamic> map = documentSnapshot.data();
    postId = map[cKeyPostId];
    texte = map[cKeyTexte];
    utilisateurUID = map[cKeyUtilisateurId];
    imageUrl = map[cKeyImageUrl];
    date = map[cKeyDate];
    likes = map[cKeyLikes];
    commentaires = map[cKeyCommentaires];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      cKeyPostId: postId,
      cKeyUtilisateurId: utilisateurUID,
      cKeyDate: date,
      cKeyLikes: likes,
      cKeyCommentaires: commentaires,
    };
    if (this.texte != null) {
      map[cKeyTexte] = texte;
    }

    if (this.imageUrl != null) {
      map[cKeyImageUrl] = imageUrl;
    }
    return map;
  }
}
