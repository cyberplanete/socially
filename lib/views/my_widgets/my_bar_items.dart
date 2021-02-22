import 'package:flutter/material.dart';
import 'package:socially/views/my_material.dart';

class MyBarItem extends IconButton {
  Icon icon;
  VoidCallback onPressed;
  bool isIconSelected;
  MyBarItem({
    @required this.icon,
    @required this.onPressed,
    @required this.isIconSelected,
  }) : super(
            icon: icon,
            onPressed: onPressed,
            color: isIconSelected ? cPointer : cBaseColor);
}
