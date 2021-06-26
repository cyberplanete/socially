import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:socially/controllers/fireStoreController.dart';
import 'package:socially/models/notificationSocially.dart';
import 'package:socially/models/post.dart';
import 'package:socially/models/utilisateurs.dart';
import 'package:socially/views/my_material.dart';
import 'package:socially/views/pages/page_ajout_commentaire.dart';
import 'package:socially/views/pages/page_listCommentaires.dart';
import 'package:socially/views/pages/page_profile.dart';

class NotificationTuile extends StatelessWidget {
  NotificationSocially notification;

  NotificationTuile({this.notification});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FireStoreController()
            .fireStore_collectionUtilisateurs
            .doc(notification.utilisateurId)
            .snapshots(),
        builder: (BuildContext buildContext,
            AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else {
            Utilisateur utilisateur = Utilisateur(snapshot.data);
            return InkWell(
              onTap: () {
                //La notification est lue alors je passe sa valeur a true
                notification.notificationRef
                    .update({cKeyIsNotificationRead: true});
                //Si il s'agit d'un abonné, alors je peux montrer son profil
                if (notification.type == cKeyAbonnes) {
                  //TODO Navigator pushNamed
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return Scaffold(
                          body: SafeArea(
                            child: PageProfil(
                              utilisateur: utilisateur,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  notification.documentReference.get().then(
                    (value) {
                      if (value == null) {
                        print("no value");
                      } else {
                        Post post = Post(documentSnapshot: value);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return PageAjoutCommentaire(
                                  utilisateur: utilisateur, post: post);
                            },
                          ),
                        );
                      }
                    },
                  );
                }
              },
              child: Container(
                color: Colors.transparent,
                margin: EdgeInsets.only(left: 5.0, top: 5.0, right: 5.0),
                child: Card(
                  elevation: 5.0,
                  color: (!notification.isNotificationSeen)
                      ? cColorWhite
                      : cColorBase,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyProfileImage(
                                onPressed: null,
                                urlString: utilisateur.imageUrl),
                            MyText(
                              dataText: notification.date,
                              color: cColorPointer,
                            )
                          ],
                        ),
                        MyText(
                          dataText: notification.texte,
                          color: cColorBaseAccent,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        });
  }
}
