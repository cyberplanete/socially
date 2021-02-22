import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socially/models/utilisateurs.dart';
import 'package:socially/views/my_material.dart';

class Post {
  DocumentReference documentReference;
  String documentID;
  String postId;
  String texte;
  String utilisateurID;
  String imageUrl;
  int date;
  List<dynamic> likes;
  List<dynamic> commentaires;
  Utilisateur utilisateur;

  Post({Utilisateur utilisateur, DocumentSnapshot documentSnapshot}) {
    this.documentReference = documentSnapshot.reference;
    this.documentID = documentSnapshot.id;
    this.utilisateur = utilisateur;
    Map<String, dynamic> map = documentSnapshot.data();
    this.postId = map[cKeyPostId];
    this.texte = map[cKeyTexte];
    this.utilisateurID = map[cKeyUtilisateurId];
    this.imageUrl = map[cKeyImageUrl];
    this.date = map[cKeyDate];
    this.likes = map[cKeyLikes];
    this.commentaires = map[cKeyCommentaires];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      cKeyPostId: this.postId,
      cKeyUtilisateurId: this.utilisateurID,
      cKeyDate: this.date,
      cKeyLikes: this.likes,
      cKeyCommentaires: this.commentaires,
    };
    if (texte != null) {
      map[cKeyTexte] = this.texte;
    }
    if (imageUrl != null) {
      map[cKeyImageUrl] = this.imageUrl;
    }

    return map;
  }
}
