import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:socially/views/my_material.dart';

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
    String utilisateurId = userCredential.user.uid;
    List<dynamic> listAbonnes = [];

    ///j'ajoute l"utilisateurId de l'utilisateur par défaut afin qu'il puisse suivre les posts écris par lui meme.
    List<dynamic> abonnementList = [utilisateurId];
    Map<String, dynamic> map = {
      cKeyNom: nom,
      ckeyPrenom: prenom,
      cKeyImageUrl: "",
      cKeyAbonnes: listAbonnes,
      cKeyAbonnementList: abonnementList,
      cKeyUtilisateurId: utilisateurId
    };
    ajouterUtilisateur(utilisateurId, map);
    return userCredential.user;
  }

  deconnexion() => firebase_auth_instance.signOut();

  ///Database
  static final firestore_instance = FirebaseFirestore.instance;
  final fireStore_collectionOfUSers =
      firestore_instance.collection("utilisateurs");

  ajouterUtilisateur(String uid, Map<String, dynamic> map) {
    fireStore_collectionOfUSers.doc(uid).set(map);
  }

  ///Stockage - Dossier utilisateurs et dossier posts
  static final stockageInstance = FirebaseStorage.instance.ref();
  final stockageUitilisateur = stockageInstance.child("utilisateurs");
  final stockagePosts = stockageInstance.child("posts");

  ///Methode permettant d'ajouter une photo - Creation d'une tache d'upload du fichier puis quand cette tache est terminée, je recupère le lien de téléchargement
  Future<String> ajouterPhoto(File file, Reference ref) async {
    String url;
    //Creation d'une tache d'upload du fichier
    UploadTask uploadTask = ref.putFile(file);
    //Quand cette tache est terminée, je recupère le lien de téléchargement
    uploadTask.whenComplete(() async => url =
        await ref.getDownloadURL().catchError((onError) => print(onError)));
    return url;
  }

  ajouterPost({String utilisateurId, String texte, File photo}) {
    int date = DateTime.now().millisecondsSinceEpoch.toInt();
    List<dynamic> listDelikes = [];
    List<dynamic> listDeCommentaires = [];
    Map<String, dynamic> unPost = {
      cKeyUtilisateurId: utilisateurId,
      cKeyLikes: listDelikes,
      cKeyCommentaires: listDeCommentaires,
      cKeyDate: DateTime.now().millisecondsSinceEpoch.toInt(),
    };
    if (texte != null && texte != "") {
      unPost[cKeyTexte] = texte;
    }
    //Je cree une collection pour un 'post ' lié à un utilisateur qui contiendra une photo
    if (photo != null) {
      //Stockage sous le dossier utilisateur et classé par date
      Reference referenceStockage =
          stockagePosts.child(utilisateurId).child(date.toString());
      ajouterPhoto(photo, referenceStockage).then((finalised) {
        String imageUrl = finalised;
        unPost[cKeyImageUrl] = imageUrl;
        fireStore_collectionOfUSers
            .doc(utilisateurId)
            .collection("posts")
            .doc()
            .set(unPost);
      });
    } else {
      //Dans tous les cas je cree une collection pour un 'post ' lié à un utilisateur.
      fireStore_collectionOfUSers
          .doc(utilisateurId)
          .collection("posts")
          .doc()
          .set(unPost);
    }
  }
}
