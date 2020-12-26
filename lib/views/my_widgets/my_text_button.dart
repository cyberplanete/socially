import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextButton extends Text {
  final String data;
  final TextAlign textAlignment;
  final double fontSize;
  final FontStyle fontStyle;
  final Color color;

  MyTextButton(
      {this.data,
      this.textAlignment = TextAlign.center,
      this.fontStyle = FontStyle.normal,
      this.color = Colors.white,
      this.fontSize = 17.0})
      : super(data,
            textAlign: textAlignment,
            style: TextStyle(
                fontSize: fontSize, fontStyle: fontStyle, color: color));
}
