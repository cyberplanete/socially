import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:socially/models/commentaire.dart';
import 'package:socially/models/post.dart';
import 'package:socially/models/utilisateurs.dart';
import 'package:socially/views/Tuiles/Post_Tuile.dart';
import 'package:socially/views/Tuiles/comment_tuile.dart';
import 'package:socially/views/my_material.dart';

/// Widget permettant d'importer et d'afficher les commentaires dans la page commentaire
class DetailPageOfCommentairePage extends StatelessWidget {
  Utilisateur utilisateur;
  Post post;

  DetailPageOfCommentairePage({this.utilisateur, this.post});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: post.documentReference.snapshots(),
      builder: (BuildContext buildContext,
          AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          Post newPost = Post(documentSnapshot: snapshot.data);
          //+1 ajouter le post concerné par les commentaires
          return ListView.builder(
              itemCount: newPost.commentaires.length + 1,
              itemBuilder: (BuildContext buildContext, int index) {
                if (index == 0) {
                  return PostTuile(
                    post: newPost,
                    utilisateur: utilisateur,
                    isPageDetail: true,
                  );
                } else {
                  //Sachant que la première ligne correspond à un post et non un commentaire. donc -1
                  Commentaire commentaire =
                      Commentaire(newPost.commentaires[index - 1]);
                  return CommentTuile(
                    commentaire: commentaire,
                  );
                }
                ;
              });
        } else {
          return MyLoadingCenter();
        }
        ;
      },
    );
  }
}
