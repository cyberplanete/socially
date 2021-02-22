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

  Utilisateur(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> map = documentSnapshot.data();
    this.documentReference = documentSnapshot.reference;
    this.documentId = documentSnapshot.id;
    this.uid = map[cKeyUtilisateurId];
    this.nom = map[cKeyNom];
    this.prenom = map[ckeyPrenom];
    this.abonnesList = map[cKeyAbonnes];
    this.abonnementList = map[cKeyAbonnementList];
    this.imageUrl = map[cKeyImageUrl];
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
