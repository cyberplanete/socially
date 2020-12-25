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
            decoration: MyGradientColorWidgetBoxDecoration(

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
                    ///Position de mes boutons pour la création ou connexion
                    ///todo modifier la couleur des boutons pour afficher le texte non visible lors du mouvement du customPaint
                    unWidget: MyMenuTwoItems(
                        itemMenu1: 'Connexion',
                        itemMenu2: 'Creation',
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

  ///Se positionne dessous les boutons - Affiche les vues contenant des textfields permettant la connexion ou la creation du compte
  Widget viewSignIn(int index) {
    return Column(
      children: [
        MyPaddingCustomWith(
          top: 50,
          bottom: 15,

          ///Padding a partir du bord de l'écran
          left: 20,
          right: 20,
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
                    margin: EdgeInsets.only(
                        left: 20, right: 20, top: 15, bottom: 15),
                  )
                ]
                //listOfUserTextField((index == 0)),
                ),
          ),
        ),

        ///Position du bouton création de compte ou connexion
        MyPaddingCustomWith(
            top: 15,
            bottom: 15,
            unWidget: Card(
              elevation: 7.5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Container(
                width: 300,
                height: 50,
                decoration: MyGradientColorWidgetBoxDecoration(
                    startColor: kBaseColor,
                    endColor: kBaseAccent,
                    radius: 25,
                    isHorizontal: true),
                child: FlatButton(
                  onPressed: null,
                  child: Text(
                    (index == 0) ? 'Se connecter' : 'Créer un compte',
                    style: TextStyle(color: kWhite),
                  ),
                ),
              ),
            ))
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
