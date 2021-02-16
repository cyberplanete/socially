import 'package:flutter/material.dart';

class MyBottomBar extends BottomAppBar {
  List<Widget> barItems;

  MyBottomBar({@required this.barItems})
      : super(
            color: Colors.blueAccent,

            /// Permet de creer une entaille pour le FloatingActionButton
            shape: CircularNotchedRectangle(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: barItems,
            ));
}
