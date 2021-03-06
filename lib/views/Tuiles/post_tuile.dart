import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socially/views/pages/page_ajout_commentaire.dart';
import 'package:socially/controllers/fireStoreController.dart';
import 'package:socially/models/post.dart';
import 'package:socially/models/utilisateurs.dart';
import 'package:socially/useful/DateHelper.dart';
import 'package:socially/views/my_material.dart';

class PostTuile extends StatelessWidget {
  final Post post;
  final Utilisateur utilisateur;
  final bool isPageDetail;

  PostTuile(
      {@required this.post,
      @required this.utilisateur,
      this.isPageDetail: false});

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
                        dataText: "${utilisateur.nom} ${utilisateur.prenom}",
                        color: cColorBaseAccent,
                      ),
                      MyText(
                        dataText: DateHelper().MyDate(post.date),
                        color: cColorPointer,
                      ),
                    ],
                  ),
                ],
              ),

              ///Une ligne bleu
              (post.imageUrl != null && post.imageUrl != "")
                  ? MyPaddingCustomWith(
                      unWidget: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 1.0,
                      color: cColorBaseAccent,
                    ))
                  : Container(
                      height: 0.0,
                    ),

              ///Affichage de l'image
              (post.imageUrl != null && post.imageUrl != "")
                  ? MyPaddingCustomWith(
                      unWidget: Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: MediaQuery.of(context).size.width * 0.85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(post.imageUrl),
                              fit: BoxFit.cover),
                        ),
                      ),
                    )
                  : Container(
                      height: 0.0,
                    ),

              ///Affichage du texte dans le commentaire
              (post.texte != null && post.texte != "")
                  ? MyPaddingCustomWith(
                      unWidget: MyText(
                      dataText: post.texte,
                      color: cColorBaseAccent,
                    ))
                  : Container(
                      height: 0.0,
                    ),

              ///Une ligne bleu
              MyPaddingCustomWith(
                unWidget: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1.0,
                  color: cColorBaseAccent,
                ),
              ),

              ///Affichage du nombre de likes et commentaires
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: (post.likes.contains(utilisateur.uid)
                        ? cIconLikeFull
                        : cIconLikeEmpty),
                    onPressed: () => FireStoreController().ajouterLike(post),
                  ),
                  MyText(
                    dataText: post.likes.length.toString(),
                    color: cColorBaseAccent,
                  ),
                  IconButton(
                      onPressed: () {
                        //Si je suis sur la page detail pour visionner les commentaires alors le bouton ajout de commentaire n'est pas activé
                        if (!isPageDetail) {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext buildContext) {
                            return PageAjoutCommentaire(
                              post: post,
                              utilisateur: utilisateur,
                            );
                          }));
                        }
                        ;
                      },
                      icon: cIconMsg),
                  MyText(
                    dataText: post.commentaires.length.toString(),
                    color: cColorBaseAccent,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
