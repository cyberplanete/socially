import 'dart:async';

import 'package:flutter/material.dart';
import 'package:socially/models/utilisateurs.dart';
import 'package:socially/useful/FireStore_logique.dart';
import 'package:socially/views/my_material.dart';
import 'package:socially/views/pages/page_fil_actualit%C3%A9s.dart';
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
  Utilisateur utilisateur;
  int index = 0;
  @override
  void initState() {
    ///je crée une souscription au stream, utilisé dans une classe utilisateur
    streamListenner = FireStoreLogique()
        .fireStore_collectionOfUSers
        .doc(widget.uid)
        .snapshots()
        .listen((event) {
      //print(event.data());
      setState(() {
        utilisateur = Utilisateur(event);
        print(utilisateur.nom);
      });
    });
  }

  @override
  void dispose() {
    ///Stopper le stream
    streamListenner.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return (utilisateur == null)
        ? MyProgressIndicatorScafold()
        : Scaffold(
            backgroundColor: kBaseColor,
            body: afficherPageOnSelectedIcon(),
            floatingActionButton: FloatingActionButton(
              onPressed: write,
              child: kWriteIcon,
              backgroundColor: kPointer,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            key: _globalKey,
            bottomNavigationBar: MyBottomBar(
              barItems: [
                ///Index est utilisé pour ajouter la couleur du bouton pressé
                MyBarItem(
                    icon: kHomeIcon,
                    onPressed: (() => buttonSelected(0)),
                    isIconSelected: index == 0),
                MyBarItem(
                    icon: kFriendsIcon,
                    onPressed: (() => buttonSelected(1)),
                    isIconSelected: index == 1),

                MyBarItem(
                    icon: kNotificationIcon,
                    onPressed: (() => buttonSelected(2)),
                    isIconSelected: index == 2),
                MyBarItem(
                    icon: kProfilIcon,
                    onPressed: (() => buttonSelected(3)),
                    isIconSelected: index == 3),
                Container(
                  width: 50,
                  height: 0,
                ), //Une largeur de 50 afin de placer mon floatingActionButton
              ],
            ),
          );
  }

  buttonSelected(int index) {
    setState(() {
      this.index = index;
    });
  }

  void write() {}

  Widget afficherPageOnSelectedIcon() {
    switch (index) {
      case 0:
        return PageFilActualite(utilisateur: utilisateur);
      case 1:
        return PageUtilisateurs(utilisateur: utilisateur);
      case 2:
        return PageNotifications(utilisateur: utilisateur);
      default:
        return PageProfil(utilisateur: utilisateur);
    }
  }
}
