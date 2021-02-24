import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socially/models/utilisateurs.dart';
import 'package:socially/views/my_widgets/my_text_widget.dart';

class PageNotifications extends StatefulWidget {
  Utilisateur utilisateur;
  PageNotifications({this.utilisateur});
  @override
  _PageNotificationsState createState() => _PageNotificationsState();
}

class _PageNotificationsState extends State<PageNotifications> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: MyText(
      dataText: "NotificationPage",
    ));
  }
}
