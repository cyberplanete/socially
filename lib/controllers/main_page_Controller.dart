import 'dart:async';

import 'package:flutter/material.dart';
import 'package:socially/models/utilisateurs.dart';
import 'package:socially/useful/FireStore_logique.dart';
import 'package:socially/views/my_material.dart';
import 'package:socially/views/my_widgets/my_bar_items.dart';
import 'package:socially/views/my_widgets/my_progress_indicator_scafold.dart';

class MainPageController extends StatefulWidget {
  String uid;

  MainPageController({this.uid});

  _StateMainAppController createState() => _StateMainAppController();
}

///Cette page est affiché quand l'utilisateur est connecté
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
            key: _globalKey,
            bottomNavigationBar: MyBottomBar(
              barItems: [
                ///Index est utilisé pour ajouter la couleur du bouton pressé
                MyBarItem(
                    icon: Icon(Icons.android),
                    onPressed: (() => buttonSelected(0)),
                    isIconSelected: index == 0),
                MyBarItem(
                    icon: Icon(Icons.android),
                    onPressed: (() => buttonSelected(1)),
                    isIconSelected: index == 1),
                MyBarItem(
                    icon: Icon(Icons.android),
                    onPressed: (() => buttonSelected(2)),
                    isIconSelected: index == 2),
              ],
            ),
            body: Center(
              child:
                  MyTextButton(data: utilisateur.nom, color: Colors.blueAccent),
            ),
          );
  }

  buttonSelected(int index) {
    setState(() {
      this.index = index;
    });
  }
}
