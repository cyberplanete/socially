import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

/// Profile image in a rectangular area of a Material that responds to touch.
class MyProfileImage extends InkWell {
  double taille = 20.0;
  String urlString;
  Function onPressed;

  MyProfileImage(
      {this.taille, @required this.onPressed, @required this.urlString})
      : super(
            onTap: onPressed,
            child: CircleAvatar(
                radius: taille,
                //urlString est null ? ou vide ?
                backgroundImage: (urlString != null && urlString != "")
                    ? CachedNetworkImageProvider(urlString)
                    : cImageLogo));
}
