import 'package:firebase_auth/firebase_auth.dart';

class FireStoreLogique {
  ///Autorisation
  final autorisation_instance = FirebaseAuth.instance;

  Future<UserCredential> connexion(String email, String pwd) async {
    final UserCredential userCredential = await autorisation_instance
        .signInWithEmailAndPassword(email: email, password: pwd);
    return userCredential;
  }

  Future<UserCredential> creationCompte(
      String email, String pwd, String nom, String prenom) async {
    final UserCredential userCredential = await autorisation_instance
        .createUserWithEmailAndPassword(email: email, password: pwd);
    return userCredential;
  }

  deconnexion() => autorisation_instance.signOut();

  ///Database

  ///Storage

}
