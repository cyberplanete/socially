import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socially/views/my_widgets/constants.dart';

class Utilisateur {
  String uid;
  String nom;
  String prenom;
  String imageUrl;
  List<dynamic> abonnesList;
  List<dynamic> abonnementList;
  DocumentReference documentReference;
  String documentId;
  String description;

  Utilisateur(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> donneesUtilisateurs = documentSnapshot.data();
    this.documentReference = documentSnapshot.reference;
    this.documentId = documentSnapshot.id;
    this.uid = donneesUtilisateurs[cKeyUtilisateurId];
    this.nom = donneesUtilisateurs[cKeyNom];
    this.prenom = donneesUtilisateurs[ckeyPrenom];
    this.abonnesList = donneesUtilisateurs[cKeyAbonnes];
    this.abonnementList = donneesUtilisateurs[cKeyAbonnementList];
    this.imageUrl = donneesUtilisateurs[cKeyImageUrl];
    this.description = donneesUtilisateurs[cKeyDescription];
  }

  Map<String, dynamic> toMap() {
    return {
      cKeyUtilisateurId: uid,
      cKeyNom: nom,
      ckeyPrenom: prenom,
      cKeyAbonnes: abonnesList,
      cKeyAbonnementList: abonnementList,
      cKeyImageUrl: imageUrl,
    };
  }
}
