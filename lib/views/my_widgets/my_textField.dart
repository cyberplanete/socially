import 'package:flutter/material.dart';

class MyTextField extends TextField {
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final String hintText;
  final icon;
  final bool hidePassword;

  MyTextField(
      {@required this.textEditingController,
      @required this.textInputType,
      this.icon,
      this.hidePassword = false,
      this.hintText = ''})
      : super(
          controller: textEditingController,
          keyboardType: textInputType,
          obscureText: hidePassword,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: hintText,
            icon: icon,
          ),
        );
}
