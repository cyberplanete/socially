import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socially/useful/DateHelper.dart';
import 'package:socially/views/my_material.dart';

class NotificationSocially {
  ///Notification reference du post
  DocumentReference notificationRef;
  String texte;
  String date;
  String utilisateurId;
  DocumentReference documentReference;
  bool isNotificationSeen;
  String type;

  NotificationSocially({DocumentSnapshot snapshot}) {
    notificationRef = snapshot.reference;
    Map<String, dynamic> map = snapshot.data();
    texte = map[cKeyTexte];
    date = DateHelper().MyDate(map[cKeyDate]);
    utilisateurId = map[cKeyUtilisateurId];
    documentReference = map[cKeyDocumentLocation];
    isNotificationSeen = map[cKeyIsNotificationRead];
    type = map[cKeyType];
  }
}
