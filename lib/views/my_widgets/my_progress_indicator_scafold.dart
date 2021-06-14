import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../my_material.dart';

class MyProgressIndicatorScafold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: MyLoadingCenter(),
      ),
    );
  }
}
