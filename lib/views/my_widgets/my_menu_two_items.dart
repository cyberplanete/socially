import 'package:flutter/material.dart';
import 'package:socially/views/my_material.dart';

class MyMenuTwoItems extends StatelessWidget {
  final String itemMenu1;
  final String itemMenu2;
  final PageController pageController;

  MyMenuTwoItems(
      {@required this.itemMenu1,
      @required this.itemMenu2,
      @required this.pageController,
      Color itemMenu1Color});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        width: 300,
        height: 50,
        decoration: BoxDecoration(
          color: kPointer,
          borderRadius: BorderRadius.all(
            Radius.circular(25.0),
          ),
        ),
        child: CustomPaint(
          painter: MyCustomPaintSignIn(pageController: pageController),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [itemButton(itemMenu1), itemButton(itemMenu2)],
          ),
        ));
  }

  Expanded itemButton(String name) {
    return Expanded(
      child: FlatButton(
        onPressed: () {
          ///Si je suis à la page 1.0 alors je passe à la page 0.0 et vis et versa
          int page = (pageController.page == 0.0) ? 1 : 0;
          pageController.animateToPage(page,
              duration: Duration(milliseconds: 500), curve: Curves.decelerate);
        },
        child: Text(
          name,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
