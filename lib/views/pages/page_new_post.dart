import 'package:flutter/cupertino.dart';
import 'package:socially/views/my_material.dart';

class PageNewPost extends StatefulWidget {
  createState() => _PageNewPost();
}

class _PageNewPost extends State<PageNewPost> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBaseColor,
      height: MediaQuery.of(context).size.height * 0.6,
    );
  }
}
