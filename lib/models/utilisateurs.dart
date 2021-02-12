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
    this.uid = map[kUid];
    this.nom = map[kNom];
    this.prenom = map[kPrenom];
    this.abonnesList = map[kAbonnes];
    this.abonnementList = map[kAbonnementList];
    this.imageUrl = map[kImageUrl];
  }

  Map<String, dynamic> toMap() {
    return {
      kUid: uid,
      kNom: nom,
      kPrenom: prenom,
      kAbonnes: abonnesList,
      kAbonnementList: abonnementList,
      kImageUrl: imageUrl,
    };
  }
}
