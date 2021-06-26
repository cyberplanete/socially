import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:socially/models/utilisateurs.dart';

///Utilisateur global
Utilisateur cUtilisateurConnecte;

///showBottomSheet
bool cIsSheetOpen = false;

///couleurs
const Color cColorWhite = const Color(0xffffffff);
const Color cColorBase = const Color(0xff42a5f5);
const Color cColorBaseAccent = const Color(0xff1976d2);
const Color cColorPointer = const Color(0xfff44336);

///Images
AssetImage cImageLogo = AssetImage('assets/logo.png');
AssetImage cImageHome = AssetImage('assets/home.jpg');
AssetImage cImageProfile = AssetImage('assets/profile.jpg');
AssetImage cImageEvent = AssetImage('assets/event.jpg');
AssetImage cImageLogoWhite = AssetImage('assets/logoWhite.png');

///Database Firestore - Clés

String cKeyNom = "nom";
String ckeyPrenom = "prenom";
String cKeyImageUrl = "imageUrl";
String cKeyAbonnes = "abonnees";
String cKeyAbonnementList = "adherents";
String cKeyUtilisateurId = "uid";
String cKeyPostId = "postID";
String cKeyTexte = "texte";
String cKeyDate = "date";
String cKeyLikes = "likes";
String cKeyCommentaires = "commentaires";
String cKeyDescription = "description";
String cKeyType = "type";
String cKeyDocumentLocation = "documentLocation";
String cKeyIsNotificationRead = "IsNotificationRead";

///Icons
Icon cIconHome = Icon(Icons.home);
Icon cIconFriends = Icon(Icons.group);
Icon cIconNotification = Icon(Icons.notifications);
Icon cIconProfil = Icon(Icons.account_circle);
Icon cIconWrite = Icon(Icons.border_color);
Icon cIconSend = Icon(Icons.send);
Icon cIconCam = Icon(Icons.camera_enhance);
Icon cIconLibrary = Icon(Icons.photo_library);
Icon cIconLikeEmpty = Icon(Icons.favorite_border);
Icon cIconLikeFull = Icon(Icons.favorite);
Icon cIconMsg = Icon(Icons.message);
Icon cIconSettings = Icon(Icons.settings);
