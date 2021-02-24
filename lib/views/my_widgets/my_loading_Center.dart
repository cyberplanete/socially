import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../my_material.dart';

class LoadingCenter extends Center {
  ///Montre la page chargement en cours
  LoadingCenter()
      : super(
            child: MyText(
          dataText: "chargement...",
          fontSize: 40.0,
          color: Colors.blueAccent,
        ));
}
