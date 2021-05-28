import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socially/controllers/fireStoreLController.dart';
import 'package:socially/views/my_material.dart';

class PageNewPost extends StatefulWidget {
  PageNewPost();

  createState() => _PageNewPost();
}

class _PageNewPost extends State<PageNewPost> {
  TextEditingController _textEditingController;
  File imagePrise;
  final GlobalKey<_PageNewPost> _globalKey = new GlobalKey<_PageNewPost>();

  _PageNewPost();
  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _globalKey,
      color: cBaseColor,
      height: MediaQuery.of(context).size.height * 0.6,
      child: Container(
        decoration: BoxDecoration(
            color: cWhite,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: InkWell(
          ///Permet de cacher le clavier onTap en dehors du textField
          onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
          child: Column(
            children: [
              MyPaddingCustomWith(
                  unWidget: MyText(
                dataText: "Ecrire un post",
                color: cBaseAccent,
                fontSize: 25.0,
              )),
              MyPaddingCustomWith(
                  unWidget: Container(
                ///je cree ce container permettant d'élargir ma bottomsheet sur toute la largeur de l'écran et ajouter une ligne de séparation
                width: MediaQuery.of(context).size.width, height: 1.0,
                color: cBaseAccent,
              )),
              MyPaddingCustomWith(
                unWidget: MyTextField(
                  textInputType: TextInputType.text,
                  textEditingController: _textEditingController,
                  hintText: "Exprimez-vous",
                  icon: cIconWrite,
                ),
                top: 25.0,
                right: 25.0,
                left: 25.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      IconButton(
                          icon: cIconCam,

                          ///Prendre une photo depuis la camera
                          onPressed: (() =>
                              prendreUnePhoto(ImageSource.camera))),
                      IconButton(
                          icon: cIconLibrary,

                          ///Prendre une photo depuis la gallery
                          onPressed: (() =>
                              prendreUnePhoto(ImageSource.gallery)))
                    ],
                  ),
                  Container(
                      width: 75.0,
                      height: 75.0,
                      child: (imagePrise == null)
                          ? MyText(
                              dataText: "Aucune image",
                              fontSize: 13.0,
                              color: cBaseAccent)
                          : Semantics(
                              child: Image.file(File(imagePrise.path)),
                              label: 'tets',
                            ))
                ],
              ),
              MyButtonGradient(callback: envoyerVersFirebase, texte: "Envoyer")
            ],
          ),
        ),
      ),
    );
  }

  Future<void> prendreUnePhoto(ImageSource camera) async {
    final PickedFile photo = await ImagePicker()
        .getImage(source: camera, maxWidth: 500.0, maxHeight: 500.0);
    setState(() {
      imagePrise = File(photo.path);
    });
  }

  ///Methode permettant d'envoyer des données vers firebaseStorage - photo et/ou texte.
  envoyerVersFirebase() {
    FocusScope.of(context).requestFocus(FocusNode());
    //Je verifie si imagePrise est different de null ainsi que la zone de texte
    Navigator.of(context).pop();
    if (imagePrise != null ||
        (_textEditingController.text != null &&
            _textEditingController.text != "")) {
      FireStoreController().ajouterPost(
          utilisateurId: cUtilisateur.uid,
          texte: _textEditingController.text,
          photo: imagePrise);

      cIsSheetOpen = false;

      //
    }
  }
}
