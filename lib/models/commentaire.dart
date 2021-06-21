import 'package:socially/useful/DateHelper.dart';
import 'package:socially/views/my_material.dart';

class Commentaire {
  String utilisateurUID;
  String texte;
  String date;

  Commentaire(Map<String, dynamic> map) {
    utilisateurUID = map[cKeyUtilisateurId];
    texte = map[cKeyTexte];
    date = DateHelper().MyDate(map[cKeyDate]);
  }
}
