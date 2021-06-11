import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socially/controllers/fireStoreController.dart';
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

  Future<void> changeUserDataAlert(BuildContext context,
      {@required TextEditingController textEditingController_nom,
      @required TextEditingController textEditingController_prenom,
      @required TextEditingController textEditingController_description}) {
    MyTextField nomTF = MyTextField(
      textEditingController: textEditingController_nom,
      hintText: cUtilisateurConnecte.nom,
    );
    MyTextField prenomTF = MyTextField(
      textEditingController: textEditingController_prenom,
      hintText: cUtilisateurConnecte.prenom,
    );
    MyTextField descriptionTF = MyTextField(
      textEditingController: textEditingController_description,
      hintText: cUtilisateurConnecte.description ?? "Aucune  description",
    );
    MyText titre = MyText(
      dataText: "Changer les données de l'utilisateur",
      color: cPointer,
    );
    return showDialog(
      context: context,
      //Obliger l'utilisateur à choisir entre oui et non -- Ici true
      barrierDismissible: false,
      builder: (BuildContext buildContext) {
        //En fonction du fait si il s'agit d'un Ios ou Android
        return (Theme.of(context).platform == TargetPlatform.iOS)
            ? CupertinoAlertDialog(
                title: titre,
                content: Column(
                  children: [nomTF, prenomTF, descriptionTF],
                ),
                actions: [
                  myButton(buildContext, 'Annuler'),
                  TextButton(
                    child: MyText(
                      dataText: "Valider",
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      Map<String, dynamic> data;
                      if (textEditingController_nom.text != null &&
                          textEditingController_nom != "")
                        data[cKeyNom] = textEditingController_nom.text;
                      if (textEditingController_prenom.text != null &&
                          textEditingController_prenom.text != "")
                        data[ckeyPrenom] = textEditingController_prenom.text;
                      if (textEditingController_description.text != null &&
                          textEditingController_description.text != "")
                        data[cKeyDescription] =
                            textEditingController_description.text;
                      FireStoreController().modificationUserData(data);
                      Navigator.pop(context);
                    },
                  ),
                ],
              )
            : AlertDialog(
                title: titre,
                content: Column(
                  children: [nomTF, prenomTF, descriptionTF],
                ),
                actions: [
                  myButton(buildContext, 'Annuler'),
                  TextButton(
                    child: MyText(
                      dataText: "Valider",
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      Map<String, dynamic> data = {};
                      if (textEditingController_nom.text != null &&
                          textEditingController_nom != "")
                        data[cKeyNom] = textEditingController_nom.text;
                      if (textEditingController_prenom.text != null &&
                          textEditingController_prenom.text != "")
                        data[ckeyPrenom] = textEditingController_prenom.text;
                      if (textEditingController_description.text != null &&
                          textEditingController_description.text != "")
                        data[cKeyDescription] =
                            textEditingController_description.text;
                      FireStoreController().modificationUserData(data);
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
      },
    );
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
        FireStoreController().deconnexion();
        Navigator.pop(buildContext);
      },
      child: MyText(
        dataText: "Oui",
        color: Colors.green,
      ),
    );
  }
}
