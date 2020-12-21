import 'package:flutter/material.dart';
import 'package:socially/views/my_material.dart';

class SigninController extends StatefulWidget {
  _SigninStateController createState() => _SigninStateController();
}

///Cette page quand l'utilisateur n'est pas connecté
class _SigninStateController extends State<SigninController> {
  PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          ///Notification received
          overScroll.disallowGlow();
          return true;
        },
        child: SingleChildScrollView(
          child: Container(
            ///Taille du container calculer en fonction de la taille de l'ecran
            width: MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).size.height > 650)

                ///Si oui j'utilise la taille de l'ecran
                ? MediaQuery.of(context).size.height
                : 650,

            ///Dégradé de couleur
            decoration: MyGradientWidgetBoxDecoration(

                ///Pour dégradé horizontal isHorizontal doit être sur true
                startColor: kBaseColor,
                endColor: kBaseAccent,
                isHorizontal: false),
            child: SafeArea(
              child: Column(
                children: [
                  MyPaddingCustomWith(
                    unWidget: Image(
                      image: kLogoWhiteImage,
                      height: 100,
                    ),
                  ),
                  MyPaddingCustomWith(
                    unWidget: MyMenuTwoItems(
                        itemMenu1: 'Connexion',
                        itemMenu2: 'Creation',
                        pageController: _pageController),
                    top: 20.0,
                    bottom: 10,
                  ),
                  Expanded(
                      flex: 2,
                      child: PageView(
                        //Retourne l'index de la page
                        controller: _pageController,
                        children: [viewSignIn(0), viewSignIn(1)],
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget viewSignIn(int index) {
    return Container(
      color: (index == 0) ? kPointer : kWhite,
    );
  }
}
