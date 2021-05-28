import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socially/models/utilisateurs.dart';
import 'package:socially/useful/alert_box.dart';
import 'package:socially/views/my_material.dart';

class MyHeaderSliverPersistent extends SliverPersistentHeaderDelegate {
  Utilisateur utilisateur;
  VoidCallback voidCallback;
  bool isScrolled;

  MyHeaderSliverPersistent(
      {@required this.utilisateur,
      @required this.voidCallback,
      @required this.isScrolled});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.0),
      padding: EdgeInsets.all(10.0),
      color: cBaseAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          isScrolled
              ? Container(width: 0.0, height: 0.0)
              : elementInkWell(
                  "${utilisateur.prenom} ${utilisateur.nom}",
                  context,
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyProfileImage(onPressed: null, urlString: utilisateur.imageUrl),
              elementInkWell(
                  utilisateur.description == null
                      ? (" Aucune description")
                      : utilisateur.description,
                  context),
            ],
          ),
          Container(
              //Ma ligne de séparation
              width: MediaQuery.of(context).size.width,
              height: 1.0,
              color: cBaseColor),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              InkWell(
                  child: MyText(
                      dataText: "Abonnés: ${utilisateur.abonnesList.length}")),
              InkWell(
                  child: MyText(
                      dataText: // -1 parce je suis mes propres posts par defaut
                          "Abonnements: ${utilisateur.abonnementList.length - 1}"))
            ],
          )
        ],
      ),
    );
  }

  ///Une zone rectangulaire qui répond au toucher.
  Widget elementInkWell(String text, BuildContext context) {
    if (utilisateur.uid == cUtilisateur.uid) {
      //A rectangular area of a Material that responds to touch.
      return InkWell(
        child: MyText(
          dataText: text,
        ),
        onTap: () => MesAlertsBox().changeUserData(context),
      );
    } else {}
  }

  @override
  double get maxExtent => (isScrolled) ? 150.0 : 200.0;

  @override
  double get minExtent => (isScrolled) ? 150.0 : 200.0;

  @override
  bool shouldRebuild(MyHeaderSliverPersistent oldDelegate) =>
      isScrolled != oldDelegate.isScrolled ||
      utilisateur != oldDelegate.utilisateur;
}