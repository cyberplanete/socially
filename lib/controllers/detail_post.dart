import 'package:flutter/material.dart';
import 'package:socially/models/post.dart';
import 'package:socially/models/utilisateurs.dart';
import 'package:socially/views/my_material.dart';

class DetailPost extends StatelessWidget {
  Utilisateur utilisateur;
  Post post;

  DetailPost({this.utilisateur, this.post});

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
                child: Container(
                  color: Colors.pink,
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
                      onPressed: () {
                        //Permet de rentrer le clavier lorsque l'utilisateur appui sur le bouton
                        FocusScope.of(context).requestFocus(FocusNode());
                        if (textEditingController != null &&
                            textEditingController.text != "") {}
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
