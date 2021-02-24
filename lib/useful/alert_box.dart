import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socially/views/my_material.dart';

class MyAlertBox {
  Future<void> error(BuildContext context, String error) async {
    MyText titre = MyText(
      dataText: 'Erreur',
      color: Colors.blueAccent,
    );
    MyText sousTitre = MyText(
      dataText: error,
      color: Colors.blueAccent,
    );

    ///If barrierDismissible is true, then tapping this barrier will cause the current route to be popped (see Navigator.pop) with null as the value.
    ///Montre une dialogBox Android ou pour Ios
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext buildContext) {
        ///En fonction du fait si il s'agit d'un Ios ou Android
        return (Theme.of(context).platform == TargetPlatform.iOS)
            ? CupertinoAlertDialog(
                title: titre,
                content: sousTitre,
                actions: [
                  close(buildContext, 'OK'),
                ],
              )
            : AlertDialog(
                title: titre,
                content: sousTitre,
                actions: [
                  close(buildContext, 'OK'),
                ],
              );
      },
    );
  }

  FlatButton close(BuildContext buildContext, String texte) {
    return FlatButton(
      onPressed: () {
        Navigator.pop(buildContext);
      },
      child: MyText(
        dataText: texte,
        color: cPointer,
      ),
    );
  }
}
