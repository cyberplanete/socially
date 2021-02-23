import 'package:flutter/material.dart';
import 'package:socially/models/utilisateurs.dart';

///Utilisateur global
Utilisateur cUtilisateur;

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

///Icons
Icon cHomeIcon = Icon(Icons.home);
Icon cFriendsIcon = Icon(Icons.group);
Icon cNotificationIcon = Icon(Icons.notifications);
Icon cProfilIcon = Icon(Icons.account_circle);
Icon cWriteIcon = Icon(Icons.border_color);
Icon cSendIcon = Icon(Icons.send);
Icon cCamIcon = Icon(Icons.camera_enhance);
Icon cLibraryIcon = Icon(Icons.photo_library);
