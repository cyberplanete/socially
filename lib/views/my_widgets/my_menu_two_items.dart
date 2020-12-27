import 'package:flutter/material.dart';
import 'package:socially/views/my_material.dart';

class MyMenuConnectOrCreate extends StatelessWidget {
  final String itemMenuName1;
  final String itemMenuName2;
  Color myColor;
  final PageController pageController;

  MyMenuConnectOrCreate(
      {@required this.itemMenuName1,
      @required this.itemMenuName2,
      @required this.pageController,
      this.myColor = Colors.black});

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
            children: [itemButton(itemMenuName1), itemButton(itemMenuName2)],
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
          myColor = (page == 1) ? Colors.black : Colors.white;
        },
        child: Text(name, style: TextStyle(color: myColor)),
      ),
    );
  }
}
