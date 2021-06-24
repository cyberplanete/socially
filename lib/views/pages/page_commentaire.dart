import 'package:flutter/material.dart';
import 'package:socially/controllers/fireStoreController.dart';
import 'package:socially/models/post.dart';
import 'package:socially/models/utilisateurs.dart';
import 'package:socially/views/Tuiles/Post_Tuile.dart';
import 'package:socially/views/my_material.dart';
import 'package:socially/views/pages/page_detail_pageCommentaire.dart';

///Page permettant d'ajouter et d'afficher un commentaire relatif à un post.
///DetailOfCommentairePage est utilisée pour lister les commentaires
class PageCommentaire extends StatelessWidget {
  Utilisateur utilisateur;
  Post post;

  PageCommentaire({this.utilisateur, this.post});

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();

    return Scaffold(
      backgroundColor: cBaseAccent,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: InkWell(
                //Ici j'affiche les commentaires du post
                child: DetailPageOfCommentairePage(
                  utilisateur: utilisateur,
                  post: post,
                ),
                onTap: () {
                  //Permet de rentrer le clavier lorsque l'utilisateur appui sur le bouton
                  FocusScope.of(context).requestFocus(FocusNode());
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 1.0,
              color: cBaseAccent,
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              height: 75,
              color: cBaseColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 100,
                    child: MyTextField(
                      textEditingController: textEditingController,
                      hintText: "Ecrivez un commentaire",
                    ),
                  ),
                  IconButton(

                      ///Envoyer le commentaire sur Firebase
                      onPressed: () {
                        //Permet de rentrer le clavier lorsque l'utilisateur appui sur le bouton
                        FocusScope.of(context).requestFocus(FocusNode());
                        if (textEditingController != null &&
                            textEditingController.text != "") {
                          FireStoreController().addCommentaire(
                              post.documentReference,
                              textEditingController.text,
                              post.utilisateurUID);
                        }
                      },
                      icon: cIconSend)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
