import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreLogique {
  ///Autorisation
  final firebase_auth_instance = FirebaseAuth.instance;

  Future<String> connexion(String email, String pwd) async {
    try {
      final UserCredential userCredential = await firebase_auth_instance
          .signInWithEmailAndPassword(email: email, password: pwd);
      //return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return e.message;
    }
  }

  Future<User> creationCompte(
      String email, String pwd, String nom, String prenom) async {
    final UserCredential userCredential = await firebase_auth_instance
        .createUserWithEmailAndPassword(email: email, password: pwd);

    ///Créer mon utilisateur pour l'ajouter dans la bdd
    String uid = userCredential.user.uid;
    List<dynamic> supporters = [];

    ///j'ajoute l"uid de l'utilisateur par défaut afin qu'il puisse suivre les posts écris par l'utilisateur
    List<dynamic> adherents = [uid];
    Map<String, dynamic> map = {
      "nom": nom,
      "prenom": prenom,
      "imageUrl": "",
      "supporters": supporters,
      "adherents": adherents,
      "uid": uid
    };
    ajouterUtilisateur(uid, map);
    return userCredential.user;
  }

  deconnexion() => firebase_auth_instance.signOut();

  ///Database
  static final data_instance = FirebaseFirestore.instance;
  final fireStore_user = data_instance.collection("utilisateurs");

  ajouterUtilisateur(String uid, Map<String, dynamic> map) {
    fireStore_user.doc(uid).set(map);
  }

  ///Storage

}
