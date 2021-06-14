import 'package:flutter/material.dart';
import 'package:socially/views/my_material.dart';

class MySliverAppBar extends SliverAppBar {
  MySliverAppBar(
      {@required String titre, @required AssetImage image, double height: 150})
      : super(
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: MyText(
                dataText: titre,
                color: cBaseAccent,
              ),
              background: Image(
                image: image,
                fit: BoxFit.cover,
              ),
            ),
            expandedHeight: 150.0);
}
