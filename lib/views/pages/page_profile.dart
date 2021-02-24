import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socially/controllers/FireStore_controller.dart';
import 'package:socially/delegate/MyHeader.dart';
import 'package:socially/models/utilisateurs.dart';
import 'package:socially/views/my_material.dart';

class PageProfil extends StatefulWidget {
  Utilisateur utilisateur;
  PageProfil({@required this.utilisateur});

  _PageProfilState createState() => _PageProfilState();
}

class _PageProfilState extends State<PageProfil> {
  bool isProfilUserConnectedUser;
  ScrollController _scrollController;
  var silverBarExpandedHeight = 200.0;
  bool get _showTitle {
    return _scrollController.hasClients &&
        _scrollController.offset > silverBarExpandedHeight - kToolbarHeight;
  }

  @override
  void initState() {
    super.initState();
    isProfilUserConnectedUser = (widget.utilisateur.uid == cUtilisateur.uid);
    _scrollController = ScrollController();
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
                actions: [],
                flexibleSpace: FlexibleSpaceBar(
                  title: MyText(
                    dataText: widget.utilisateur.nom,
                  ),
                  background: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: cProfileImage, fit: BoxFit.cover)),
                  ),
                ),
              ),
              SliverPersistentHeader(
                  delegate: Myheader(
                      utilisateur: widget.utilisateur,
                      voidCallback: null,
                      isScrolled: _showTitle),
                  pinned: true),
              SliverList(delegate:
                  SliverChildBuilderDelegate((BuildContext context, index) {
                return ListTile(
                    title: MyText(dataText: "Nouvelle tile: $index}"));
              })),
            ],
          );
        }
      },
      stream: FireStoreLogique().getUserPosts(widget.utilisateur.uid),
    );
  }
}
