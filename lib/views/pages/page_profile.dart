import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socially/controllers/fireStoreLogique.dart';
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
  }

  @override
  void dispose() {
    _scrollController.dispose();
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
                              onPressed: null,
                              urlString: widget.utilisateur.imageUrl))),
                ),
              ),
              SliverPersistentHeader(
                  delegate: MyHeaderSliverPersistent(
                      utilisateur: widget.utilisateur,
                      voidCallback: null,
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
      stream: FireStoreLogique().getUserPostsFrom(widget.utilisateur.uid),
    );
  }
}
