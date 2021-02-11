import 'dart:async';

import 'package:flutter/material.dart';
import 'package:socially/useful/FireStore_logique.dart';
import 'package:socially/views/my_material.dart';
import 'package:socially/views/my_widgets/my_progressBar_scafold.dart';

class MainAppController extends StatefulWidget {
  String uid;
  MainAppController({this.uid});

  _StateMainAppController createState() => _StateMainAppController();
}

///Cette page est affiché quand l'utilisateur est connecté
class _StateMainAppController extends State<MainAppController> {
  StreamSubscription streamListenner;

  @override
  void initState() {
    ///je crée une souscription au stream utilisé dans une classe utilisateur
    streamListenner = FireStoreLogique()
        .fireStore_collectionOfUSers
        .doc(widget.uid)
        .snapshots()
        .listen((event) {
      print(event.data());
    });
  }

  @override
  void dispose() {
    ///Stopper le stream
  }

  @override
  Widget build(BuildContext context) {
    return MyProgressScafold();
  }
}
