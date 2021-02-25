import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socially/models/utilisateurs.dart';
import 'package:socially/views/my_material.dart';

class Myheader extends SliverPersistentHeaderDelegate {
  Utilisateur utilisateur;
  VoidCallback voidCallback;
  bool isScrolled;

  Myheader(
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
              ? Container(
                  width: 0.0,
                  height: 0.0,
                )
              : MyText(
                  dataText: "${utilisateur.prenom} ${utilisateur.nom}",
                )
        ],
      ),
    );
  }

  @override
  double get maxExtent => (isScrolled) ? 150.0 : 200.0;

  @override
  double get minExtent => (isScrolled) ? 150.0 : 200.0;

  @override
  bool shouldRebuild(Myheader oldDelegate) =>
      isScrolled != oldDelegate.isScrolled ||
      utilisateur != oldDelegate.utilisateur;
}
