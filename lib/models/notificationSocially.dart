import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socially/useful/DateHelper.dart';
import 'package:socially/views/my_material.dart';

class NotificationSocially {
  String texte;
  String date;
  String utilisateurId;
  DocumentReference documentReference;
  bool isNotificationSeen;
  String type;
  Map<String, dynamic> map;

  NotificationSocially({this.map}) {
    texte = map[cKeyTexte];
    date = DateHelper().MyDate(map[cKeyDate]);
    utilisateurId = map[cKeyUtilisateurId];
    documentReference = map[cKeyDocumentLocation];
    isNotificationSeen = map[cKeyIsNotificationRead];
    type = map[cKeyType];
  }
}
