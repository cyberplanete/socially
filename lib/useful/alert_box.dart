import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socially/controllers/fireStoreLogique.dart';
import 'package:socially/views/my_material.dart';

///Classe utiliser utiliser pour afficher divers alertBox
class MesAlertsBox {
  //Afficher une erreur si signin non reussi
  Future<void> errorSignInAlert(BuildContext context, String error) async {
    MyText titre = MyText(
      dataText: 'Erreur',
      color: Colors.blueAccent,
    );
    MyText sousTitre = MyText(
      dataText: error,
      color: Colors.blueAccent,
    );
    //If barrierDismissible is true, then tapping this barrier will cause the current route to be popped (see Navigator.pop) with null as the value.
    //Montre une dialogBox Android ou pour Ios
    return showDialog(
      context: context,
      //Obliger l'utilisateur à choisir entre oui et non -- Ici non
      barrierDismissible: true,
      builder: (BuildContext buildContext) {
        //En fonction du fait si il s'agit d'un Ios ou Android
        return (Theme.of(context).platform == TargetPlatform.iOS)
            ? CupertinoAlertDialog(
                title: titre,
                content: sousTitre,
                actions: [
                  myButton(buildContext, 'OK'),
                ],
              )
            : AlertDialog(
                title: titre,
                content: sousTitre,
                actions: [
                  myButton(buildContext, 'OK'),
                ],
              );
      },
    );
  }

  ///Deconnexion de l'utilisateur
  Future<void> disconnectAlert(BuildContext context) async {
    MyText titre = MyText(
      dataText: 'Voulez-vous vous déconnecter ?',
      color: cBaseColor,
    );
    //If barrierDismissible is true, then tapping this barrier will cause the current route to be popped (see Navigator.pop) with null as the value.
    //Montre une dialogBox Android ou pour Ios
    return showDialog(
      context: context,
      //Obliger l'utilisateur à choisir entre oui et non -- Ici true
      barrierDismissible: false,
      builder: (BuildContext buildContext) {
        //En fonction du fait si il s'agit d'un Ios ou Android
        return (Theme.of(context).platform == TargetPlatform.iOS)
            ? CupertinoAlertDialog(
                title: titre,
                actions: [
                  myButton(buildContext, 'Non'),
                  disconnectButton(context),
                ],
              )
            : AlertDialog(
                title: titre,
                actions: [
                  myButton(buildContext, 'Non'),
                  disconnectButton(buildContext)
                ],
              );
      },
    );
  }

  ///A modal bottom sheet is an alternative to a menu or a dialog and prevents the user from interacting with the rest of the app.
  void changeUserData(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: cBaseColor,
          );
        });
  }

  TextButton myButton(BuildContext buildContext, String texte) {
    return TextButton(
      onPressed: () {
        Navigator.pop(buildContext);
      },
      child: MyText(
        dataText: texte,
        color: cPointer,
      ),
    );
  }

  TextButton disconnectButton(BuildContext buildContext) {
    return TextButton(
      onPressed: () {
        FireStoreLogique().deconnexion();
        Navigator.pop(buildContext);
      },
      child: MyText(
        dataText: "Oui",
        color: Colors.blue,
      ),
    );
  }
}
