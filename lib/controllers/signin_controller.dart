import 'package:flutter/material.dart';
import 'package:socially/views/my_material.dart';

class SigninController extends StatefulWidget {
  _SigninStateController createState() => _SigninStateController();
}

///Cette page quand l'utilisateur n'est pas connecté
class _SigninStateController extends State<SigninController> {
  PageController _pageController;
  TextEditingController _mail;
  TextEditingController _nom;
  TextEditingController _prenom;
  TextEditingController _password;

  @override
  void initState() {
    _pageController = PageController();
    _mail = TextEditingController();
    _nom = TextEditingController();
    _prenom = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  ///Libère les ressources -- Appelé lors du changement de state de la page - Exemple: Lors d'un changement de page
  @override
  void dispose() {
    _mail.dispose();
    _nom.dispose();
    _prenom.dispose();
    _password.dispose();
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
            ///Taille de la page calculé en fonction de la taille de l'ecran
            width: MediaQuery.of(context).size.width,

            ///Taille supérieur à 650 alors la totalite de l'ecran est utilisée
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
                  ///Position de mon logo
                  MyPaddingCustomWith(
                    unWidget: Image(
                      image: kLogoWhiteImage,
                      height: 100,
                    ),
                  ),
                  MyPaddingCustomWith(
                    ///Position de mes boutons
                    unWidget: MyMenuTwoItems(
                        itemMenu1: 'Connexion',
                        itemMenu2: 'Creation',
                        itemMenu1Color:
                            (_pageController.page == 0) ? Colors.black : kWhite,
                        pageController: _pageController),
                    top: 20.0,
                    bottom: 10,
                  ),
                  Expanded(
                    flex: 2,

                    ///Position du slider en bas de page contenant deux containers
                    child: PageView(
                      //Retourne l'index de la page
                      controller: _pageController,
                      children: [viewSignIn(0), viewSignIn(1)],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ///Se positionne dessous les boutons
  Widget viewSignIn(int index) {
    return Column(
      children: [
        MyPaddingCustomWith(
          top: 50,
          bottom: 15,

          ///Padding a partir du bord de l'écran
          left: 15,
          right: 15,
          unWidget: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            color: kWhite,
            elevation: 7,

            ///Card invisible si pas de child !!!
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                ///l'index 0 est pour un utilisateur deja enregistré
                children: [
                  Container(
                    child: Column(
                      children: listOfUserTextField((index == 0)),
                    ),
                    margin: EdgeInsets.all(20),
                  )
                ]
                //listOfUserTextField((index == 0)),
                ),
          ),
        )
      ],
    );
  }

  /// IsUserExist est déterminé par l'index de la page -  Si je suis sur la premiere page alors l'utisateur exist - Choix de l'utilisateur
  List<Widget> listOfUserTextField(bool isUserExist) {
    List<Widget> listOfWidgetTextField = [];

    if (!isUserExist) {
      listOfWidgetTextField.add(
        MyTextField(
          textEditingController: _nom,
          textInputType: TextInputType.name,
          hintText: 'Entrez votre nom',
        ),
      );
      listOfWidgetTextField.add(
        MyTextField(
          textEditingController: _prenom,
          textInputType: TextInputType.name,
          hintText: 'Entrez votre prénom',
        ),
      );
    }
    listOfWidgetTextField.add(
      MyTextField(
        textEditingController: _mail,
        textInputType: TextInputType.emailAddress,
        hintText: 'Entrez votre adresse email',
      ),
    );
    listOfWidgetTextField.add(
      MyTextField(
        textEditingController: _password,
        textInputType: TextInputType.name,
        hidePassword: true,
        hintText: 'Entrer votre mot de passe',
      ),
    );

    return listOfWidgetTextField;
  }
}
