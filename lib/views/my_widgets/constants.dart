import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:socially/models/utilisateurs.dart';

///Utilisateur global
Utilisateur cUtilisateurConnecte;

///showBottomSheet
bool cIsSheetOpen = false;

///couleurs
const Color cWhite = const Color(0xffffffff);
const Color cBaseColor = const Color(0xff42a5f5);
const Color cBaseAccent = const Color(0xff1976d2);
const Color cPointer = const Color(0xfff44336);

///Images
AssetImage cLogoImage = AssetImage('assets/logo.png');
AssetImage cHomeImage = AssetImage('assets/home.jpg');
AssetImage cProfileImage = AssetImage('assets/profile.jpg');
AssetImage cEventImage = AssetImage('assets/event.jpg');
AssetImage cLogoWhiteImage = AssetImage('assets/logoWhite.png');

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
String cKeyCommentaires = " commentaires";
String cKeyDescription = "description";

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
