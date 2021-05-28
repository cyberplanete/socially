import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socially/controllers/fireStoreLController.dart';
import 'package:socially/delegate/MyHeader.dart';
import 'package:socially/models/post.dart';
import 'package:socially/models/utilisateurs.dart';
import 'package:socially/useful/alert_box.dart';
import 'package:socially/views/Tuiles/commentaireTuile.dart';
import 'package:socially/views/my_material.dart';

///Classe utiliser pour afficher le profil utilisateur
class PageProfil extends StatefulWidget {
  Utilisateur utilisateur;

  PageProfil({@required this.utilisateur});

  _PageProfilState createState() => _PageProfilState();
}

class _PageProfilState extends State<PageProfil> {
  TextEditingController textEditingController_nom;
  TextEditingController textEditingController_prenom;
  TextEditingController textEditingController_description;
  File imagePrise;
  bool isProfilUserConnectedUser = false;
  ScrollController _scrollController;
  var silverBarExpandedHeight = 200.0;

  /// Si IsScrolled true ou false - Le nom et prenom sera affiché soit dans SliverAppBar(FlexibleSpace) ou SliverPersistentHeader
  bool get _showTitleIf {
    return _scrollController.hasClients &&
        _scrollController.offset > (silverBarExpandedHeight - kToolbarHeight);
  }

  @override
  void initState() {
    super.initState();
    isProfilUserConnectedUser = (widget.utilisateur.uid == cUtilisateur.uid);
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          print('scrolling');
        });
      });
    textEditingController_nom = TextEditingController();
    textEditingController_prenom = TextEditingController();
    textEditingController_description = TextEditingController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    textEditingController_nom.dispose();
    textEditingController_prenom.dispose();
    textEditingController_description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return LoadingCenter();
        } else {
          //Je recupère une liste de documents firestore
          List<DocumentSnapshot> documents = snapshot.data.docs;
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: silverBarExpandedHeight,
                actions: [
                  (isProfilUserConnectedUser)
                      ? IconButton(
                          onPressed: () =>
                              MesAlertsBox().disconnectAlert(context),
                          icon: cIconSettings,
                          color: cPointer)
                      : MyText(dataText: "Suivre ou ne plus suivre")
                ],
                flexibleSpace: FlexibleSpaceBar(
                  title: MyText(
                      // Afin que le nom et prenom apparaissent.. j'ai ajouter un addListener à mon controller puis setState
                      dataText: _showTitleIf
                          ? widget.utilisateur.prenom +
                              " " +
                              widget.utilisateur.nom
                          : ""),
                  background: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: cProfileImage, fit: BoxFit.cover)),
                      child: Center(
                          child: MyProfileImage(
                              taille: 75.0,
                              onPressed: changeUserPhoto,
                              urlString: widget.utilisateur.imageUrl))),
                ),
              ),
              SliverPersistentHeader(
                  delegate: MyHeaderSliverPersistent(
                      utilisateur: widget.utilisateur,
                      callbackFunctionChangeUserData: null,
                      isScrolled: _showTitleIf),
                  pinned: true),
              // Aficher la liste des commentaires
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, index) {
                    if (index == documents.length) {
                      return ListTile(
                        title: MyText(dataText: "Fin de liste"),
                      );
                    }
                    if (index > documents.length) {
                      return null;
                    }
                    // Recupère le commentaire à l'index depuis la liste documentSnapshot
                    Post post = Post(documentSnapshot: documents[index]);
                    return CommentaireTuile(
                        post: post, utilisateur: widget.utilisateur);
                  },
                ),
              ),
            ],
          );
        }
      },
      stream: FireStoreController().getUserPostsFrom(widget.utilisateur.uid),
    );
  }

  //A modal bottom sheet is an alternative to a menu or a dialog and prevents the user from interacting with the rest of the app.
  ///Permet de changer la photo de l'utilisateur
  void changeUserPhoto() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            // canvas Transparence definie par defaut dans le widget materialApp de main.dart - Utilisé ici pour plus de clarté du code
            color: Colors.transparent,
            child: Card(
              elevation: 5.0,
              //Inner padding depuis le container -- Padding interieur
              margin: EdgeInsets.all(7.5),
              child: Container(
                color: cBaseAccent,
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MyText(
                      dataText: "Modification de la photo de profil",
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () =>
                                prendreUnePhoto(ImageSource.camera),
                            icon: cIconCam),
                        IconButton(
                            onPressed: () =>
                                prendreUnePhoto(ImageSource.gallery),
                            icon: cIconLibrary)
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> prendreUnePhoto(ImageSource camera) async {
    final PickedFile photo = await ImagePicker()
        .getImage(source: camera, maxWidth: 500.0, maxHeight: 500.0);
    setState(() {
      imagePrise = File(photo.path);
      FireStoreController().modificationPhoto(imagePrise);
    });
  }

  void validerChangementDataUser() {}
}
// MyTextField(
// textEditingController: textEditingController_nom,
// hintText: widget.utilisateur.nom,
// ),
// MyTextField(
// textEditingController: textEditingController_prenom,
// hintText: widget.utilisateur.prenom,
// ),
// MyTextField(
// textEditingController: textEditingController_description,
// hintText: widget.utilisateur.description ??
// "Aucune  description",
// ),
// MyButtonGradient(
// callback: validerChangementDataUser,
// texte: "Valider les changements")
