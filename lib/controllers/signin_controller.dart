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
    super.initState();
    _pageController = PageController();
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
                startColor: kBase,
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
                        pageController: null),
                    top: 20.0,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
