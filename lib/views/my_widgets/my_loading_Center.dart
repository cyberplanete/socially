import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../my_material.dart';

class LoadingCenter extends Center {
  LoadingCenter()
      : super(
            child: MyTextButton(
          dataText: "chargement...",
          fontSize: 40.0,
          color: Colors.blueAccent,
        ));
}
