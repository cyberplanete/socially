import 'package:flutter/material.dart';
import 'package:socially/views/my_material.dart';

class MyButtonGradient extends Card {
  double elevation;
  VoidCallback callback;
  double width;
  double height;
  String texte;
  MyButtonGradient(
      {this.elevation: 7.5,
      @required this.callback,
      this.width: 300,
      this.height: 50,
      @required this.texte})
      : super(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Container(
            width: width,
            height: height,
            decoration: MyGradientColorWidgetBoxDecoration(
                startColor: kBaseColor,
                endColor: kBaseAccent,
                radius: 25,
                isHorizontal: true),
            child: FlatButton(
              onPressed: callback,
              child: MyTextButton(dataText: texte),
            ),
          ),
        );
}
