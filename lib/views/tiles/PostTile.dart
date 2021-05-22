import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socially/models/post.dart';
import 'package:socially/models/utilisateurs.dart';
import 'package:socially/views/my_material.dart';

class PostTile extends StatelessWidget {
  final Post post;
  final Utilisateur utilisateur;
  final bool detail;

  PostTile({@required this.post, @required this.utilisateur, this.detail});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 5.0),
        child: Card(
          elevation: 5.0,
          child: MyPaddingCustomWith(
              top: 10.0,
              left: 10.0,
              right: 10.0,
              bottom: 10.0,
              unWidget: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyProfileImage(
                          onPressed: null, urlString: utilisateur.imageUrl),
                      Column(
                        children: [
                          MyText(
                            dataText:
                                "${utilisateur.nom} ${utilisateur.prenom}",
                            color: cBaseAccent,
                          ),
                          MyText(
                            dataText: "${post.date}",
                            color: cPointer,
                          )
                        ],
                      )
                    ],
                  ),
                  (post.imageUrl != null && post.imageUrl != "")
                      ? Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          height: MediaQuery.of(context).size.width * 0.85,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    CachedNetworkImageProvider(post.imageUrl),
                                fit: BoxFit.cover),
                          ),
                        )
                      : Container(
                          height: 0.0,
                        )
                ],
              )),
        ));
  }
}
