import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socially/controllers/fireStoreController.dart';
import 'package:socially/models/notificationSocially.dart';
import 'package:socially/models/utilisateurs.dart';
import 'package:socially/views/Tuiles/notification_tuile.dart';
import 'package:socially/views/my_material.dart';
import 'package:socially/views/my_widgets/my_text_widget.dart';

class PageNotifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FireStoreController()
          .firestore_collectionNotifications
          .doc(cUtilisateurConnecte.uid)
          .collection("simpleNotification")
          .snapshots(),
      builder:
          (BuildContext buildContext, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: MyText(
              dataText: "Aucune notification",
              color: cColorPointer,
              fontSize: 40,
            ),
          );
        } else {
          List<DocumentSnapshot> listNotificationSnapshot = snapshot.data.docs;

          return ListView.builder(
            itemBuilder: (BuildContext buildContext, int index) {
              NotificationSocially notification = NotificationSocially(
                  snapshot: listNotificationSnapshot[index]);
              return NotificationTuile(notification: notification);
            },
            itemCount: listNotificationSnapshot.length,
          );
        }
      },
    );
  }
}
