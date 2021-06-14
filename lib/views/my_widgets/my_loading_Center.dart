import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../my_material.dart';

class MyLoadingCenter extends Center {
  ///Montre un indicateur de progression  -- la page chargement en cours
  MyLoadingCenter()
      : super(
            child: Container(
          padding: EdgeInsets.all(16),
          color: Colors.black.withOpacity(0.8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [_getLoadingIndicator(), _getHeading(), _getText('Text')],
          ),
        ));
}

Widget _getLoadingIndicator() {
  return Padding(
    child: Container(
      child: CircularProgressIndicator(
        strokeWidth: 3,
      ),
      width: 32,
      height: 32,
    ),
    padding: EdgeInsets.only(bottom: 16),
  );
}

Widget _getHeading() {
  return Padding(
      child: Text(
        'Please wait …',
        style: TextStyle(color: Colors.white, fontSize: 16),
        textAlign: TextAlign.center,
      ),
      padding: EdgeInsets.only(bottom: 4));
}

Widget _getText(String displayedText) {
  return Text(
    displayedText,
    style: TextStyle(color: Colors.white, fontSize: 14),
    textAlign: TextAlign.center,
  );
}
