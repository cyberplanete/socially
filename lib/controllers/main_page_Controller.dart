import 'dart:async';

import 'package:flutter/material.dart';
import 'package:socially/controllers/fireStoreLogique.dart';
import 'package:socially/models/utilisateurs.dart';
import 'package:socially/views/my_material.dart';
import 'package:socially/views/pages/page_fil_actualit%C3%A9s.dart';
import 'package:socially/views/pages/page_new_post.dart';
import 'package:socially/views/pages/page_notifications.dart';
import 'package:socially/views/pages/page_profile.dart';
import 'package:socially/views/pages/page_utilisateurs_.dart';

class MainPageController extends StatefulWidget {
  String uid;

  MainPageController({this.uid});

  _StateMainAppController createState() => _StateMainAppController();
}

///Cette page est affiché quand l'utilisateur est connecté , contenant une bottomBarNavigation
class _StateMainAppController extends State<MainPageController> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  StreamSubscription streamListenner;
  PersistentBottomSheetController persisitantBottomSheetcontroller;

  int index = 0;
  @override
  void initState() {
    ///je crée une souscription au stream, utilisé dans une classe utilisateur
    streamListenner = FireStoreLogique()
        .fireStore_collectionOfUSers
        .doc(widget.uid)
        .snapshots()
        .listen((document) {
      //print(event.data());
      setState(() {
        cUtilisateur = Utilisateur(document);
        print(cUtilisateur.nom);
      });
    });
  }

  @override
  void dispose() {
    ///Stopper le stream
    streamListenner.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (cUtilisateur == null)
        ? MyProgressIndicatorScafold()
        : SafeArea(
            child: Scaffold(
              backgroundColor: cBaseColor,

              body: afficherPageOnSelectedIcon(),
              key: _globalKey,
              bottomNavigationBar: MyBottomBar(
                barItems: [
                  ///Index est utilisé pour ajouter la couleur du bouton pressé
                  MyBarItem(
                      //Si un index est = à la valeur du bouton selectionné alors la couleur de celui-ci est modifié
                      icon: cIconHome,
                      onPressed: (() => buttonSelected(0)),
                      isIconSelected: index == 0),
                  MyBarItem(
                      icon: cIconFriends,
                      onPressed: (() => buttonSelected(1)),
                      isIconSelected: index == 1),

                  MyBarItem(
                      icon: cIconNotification,
                      onPressed: (() => buttonSelected(2)),
                      isIconSelected: index == 2),
                  MyBarItem(
                      icon: cIconProfil,
                      onPressed: (() => buttonSelected(3)),
                      isIconSelected: index == 3),
                  Container(
                    width: 50,
                    height: 0,
                  ), //Une largeur de 50 afin de placer mon floatingActionButton
                ],
              ),

              ///FloatingActionButton
              floatingActionButton: FloatingActionButton(
                onPressed: writePost,
                child: cIconWrite,
                backgroundColor: cPointer,
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endDocked,
            ),
          );
  }

  buttonSelected(int index) {
    setState(() {
      this.index = index;
    });
  }

  ///Quand mon floating bouton est pressé, je verifie la page PageNewPost est visible.
  /// Si visible (persisitantBottomSheetcontroller n'est pas null) je ferme la page
  /// et j'initialise  persisitantBottomSheetcontroller a null ainsi permettant une ouverture fermeture de la page PageNewPost
  void writePost() {
    if (!cIsSheetOpen) {
      persisitantBottomSheetcontroller =
          _globalKey.currentState.showBottomSheet((context) => PageNewPost());
      cIsSheetOpen = true;
    } else {
      Navigator.of(context).pop();
      //   persisitantBottomSheetcontroller.close();
      //   persisitantBottomSheetcontroller = null;
      cIsSheetOpen = false;
    }
  }

  Widget afficherPageOnSelectedIcon() {
    switch (index) {
      case 0:
        return PageFilActualite();
      case 1:
        return PageUtilisateurs();
      case 2:
        return PageNotifications();
      default:
        return PageProfil(utilisateur: cUtilisateur);
    }
  }
}
