import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:socially/views/my_material.dart';

class FireStoreLogique {
  ///Autorisation
  final firebase_auth_instance = FirebaseAuth.instance;

  ///Database
  static final firestore_instance = FirebaseFirestore.instance;
  final fireStore_collectionOfUSers =
      firestore_instance.collection("utilisateurs");

  /// Methode signin avec email et password - retourne une erreur si probleme de connexion
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

  ///Methode pour la deconnexion de l'utilisateur
  deconnexion() => firebase_auth_instance.signOut();

  ///Méthode pour la création de compte
  Future<User> creationCompte(
      String email, String pwd, String nom, String prenom) async {
    final UserCredential userCredential = await firebase_auth_instance
        .createUserWithEmailAndPassword(email: email, password: pwd);

    //Créer mon utilisateur pour l'ajouter dans la bdd
    String utilisateurId = userCredential.user.uid;
    List<dynamic> listAbonnes = [];

    //j'ajoute l"utilisateurId de l'utilisateur par défaut afin qu'il puisse suivre les posts écris par lui meme.
    List<dynamic> abonnementList = [utilisateurId];
    Map<String, dynamic> donneesUtilisateur = {
      cKeyNom: nom,
      ckeyPrenom: prenom,
      cKeyImageUrl: "",
      cKeyAbonnes: listAbonnes,
      cKeyAbonnementList: abonnementList,
      cKeyUtilisateurId: utilisateurId
    };
    ajouterUtilisateur(utilisateurId, donneesUtilisateur);
    return userCredential.user;
  }

  ///Méthode permettant l'ajout des données utilisateur dans firebase
  ajouterUtilisateur(String uid, Map<String, dynamic> map) {
    fireStore_collectionOfUSers.doc(uid).set(map);
  }

  ///Stockage - Dossier utilisateurs et dossier posts
  static final stockageInstance = FirebaseStorage.instance.ref();
  //Je cree un emplacement de stockage pour les utlisateurs
  final stockageUitilisateur = stockageInstance.child("utilisateurs");
  //Je cree un emplacement de stockage pour les posts
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

  ///Methode permettant l'ajout d'un post
  ajouterPost({String utilisateurId, String texte, File photo}) {
    int date = DateTime.now().millisecondsSinceEpoch.toInt();
    List<dynamic> listDelikes = [];
    List<dynamic> listDeCommentaires = [];
    Map<String, dynamic> donneesDuPost = {
      cKeyUtilisateurId: utilisateurId,
      cKeyLikes: listDelikes,
      cKeyCommentaires: listDeCommentaires,
      cKeyDate: DateTime.now().millisecondsSinceEpoch.toInt(),
    };
    if (texte != null && texte != "") {
      donneesDuPost[cKeyTexte] = texte;
    }
    //Je cree une collection pour un 'post ' lié à un utilisateur qui contiendra une photo
    if (photo != null) {
      //Le stockage du post se fera dans un dossier utilisateur et classé par date
      Reference emplacementStockagePost =
          stockagePosts.child(utilisateurId).child(date.toString());
      ajouterPhoto(photo, emplacementStockagePost).then((finalised) {
        String imageUrl = finalised;
        donneesDuPost[cKeyImageUrl] = imageUrl;
        fireStore_collectionOfUSers
            .doc(utilisateurId)
            .collection("posts")
            .doc()
            .set(donneesDuPost);
      });
    } else {
      //Dans tous les cas je cree une collection pour un 'post ' lié à un utilisateur.
      fireStore_collectionOfUSers
          .doc(utilisateurId)
          .collection("posts")
          .doc()
          .set(donneesDuPost);
    }
  }

  ///Cette methode retourne la liste des posts pour un utilisateur
  Stream<QuerySnapshot> getUserPosts(String uid) =>
      fireStore_collectionOfUSers.doc(uid).collection("posts").snapshots();
}
