import 'package:flutter/material.dart';
import 'package:socially/useful/FireStore_logique.dart';
import 'package:socially/useful/alert_box.dart';
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
    /// InputText Zones d'insertion de texte
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

  ///You can dismiss the keyboard by taking away the focus of the TextFormField and giving it to an unused FocusNode
  /// FocusScope.of(context).requestFocus(FocusNode());
  /// Flutter 1.17.3 stable channel as of June 2020
  hideKeyboard() {
    FocusManager.instance.primaryFocus.unfocus();
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

            ///A rectangular area of a Material that responds to touch
            child: InkWell(
          onTap: () {
            ///You can dismiss the keyboard by taking away the focus of the TextFormField and giving it to an unused FocusNode
            /// FocusScope.of(context).requestFocus(FocusNode());
            /// Flutter 1.17.3 stable channel as of June 2020
            hideKeyboard();
          },
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
                    unWidget: MyMenuConnectOrCreate(
                        itemMenuName1: 'Connexion',
                        itemMenuName2: 'Creation',
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
        )),
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
                  onPressed: () => seConnecter(index == 0),
                  child: MyTextButton(
                    ///Nom en fonction de l'index de la page
                    dataText: (index == 0) ? 'Se connecter' : 'Créer un compte',
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

  seConnecter(bool isUserExist) async {
    hideKeyboard();
    if (_mail.text != null && _mail.text != '') {
      if (_password.text != null && _password.text != '') {
        if (isUserExist) {
          ///Connection avec mail et password
          var message_retour =
              await FireStoreLogique().connexion(_mail.text, _password.text);

          /// Si erreur lors de la création de compte, j'affiche un message d'erreur
          if (message_retour != null) {
            MyAlertBox().error(context, message_retour.toString());
          }
        } else {
          ///Verification nom et prenom puis inscription
          if (_nom.text != null && _nom.text != '') {
            if (_prenom.text != null && _prenom.text != '') {
              ///inscription
              FireStoreLogique().creationCompte(
                  _mail.text, _password.text, _nom.text, _prenom.text);
            } else {
              ///alerte box pas de prenom
              MyAlertBox().error(context, 'Pas de prénom');
            }
          } else {
            ///alerte box pas de nom
            MyAlertBox().error(context, 'Pas de nom');
          }
        }
      } else {
        ///alerte box pas de password
        MyAlertBox().error(context, 'Pas de password');
      }
    } else {
      ///alerte box pas de mail
      MyAlertBox().error(context, 'Une adresse mail doit être ajoutée');
    }
  }
}
