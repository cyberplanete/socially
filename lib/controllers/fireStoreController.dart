import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:socially/models/commentaire.dart';
import 'package:socially/models/post.dart';
import 'package:socially/models/utilisateurs.dart';
import 'package:socially/views/my_material.dart';

class FireStoreController {
  ///Autorisation
  final firebase_auth_instance = FirebaseAuth.instance;

  ///bases de données
  static final firestore_instance = FirebaseFirestore.instance;
  final fireStore_collectionUtilisateurs =
      firestore_instance.collection("utilisateurs");
  final firestore_collectionNotifications =
      firestore_instance.collection("notifications");

  ///Stockage - Creation Dossier utilisateurs et dossier posts
  static final stockageInstance = FirebaseStorage.instance.ref();
  //Je cree un emplacement de stockage pour les utlisateurs
  final stockageUitilisateur = stockageInstance.child("utilisateurs");
  //Je cree un emplacement de stockage pour les posts
  final stockagePosts = stockageInstance.child("posts");

  /// Methode signin avec email et password - retourne une erreur si probleme de connexion
  Future<User> connexion(String email, String pwd) async {
    try {
      final UserCredential userCredential = await firebase_auth_instance
          .signInWithEmailAndPassword(email: email, password: pwd);
      final User user = userCredential.user;
      return user;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      //return e.message;
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
    //j'ajoute l"utilisateurId de l'utilisateur par défaut afin qu'il puisse suivre les posts écris par lui meme.
    String utilisateurId = userCredential.user.uid;
    List<dynamic> listAbonnes = [utilisateurId];

    List<dynamic> abonnementList = [];
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
    fireStore_collectionUtilisateurs.doc(uid).set(map);
  }

  ///Methode permettant l'ajout d'une notification.
  ajouterNotification(String from, String to, String texte,
      DocumentReference documentLocation, String type) {
    Map<String, dynamic> map = {
      cKeyUtilisateurId: from,
      cKeyTexte: texte,
      cKeyType: type,
      cKeyDocumentLocation: documentLocation,
      cKeyDate: DateTime.now().millisecondsSinceEpoch.toInt()
    };
    firestore_collectionNotifications
        .doc(to)
        .collection("simpleNotification")
        .add(map);
  }

  ///Méthode permettant la mise à jour des données utilisateurs
  modificationDonneeUtilisateur(Map<String, dynamic> data) {
    fireStore_collectionUtilisateurs.doc(cUtilisateurConnecte.uid).update(data);
  }

  ///Methode permettant d'ajouter une photo - Creation d'une tache d'upload du fichier puis quand cette tache est terminée, je recupère le lien de téléchargement
  ///utilisé pour récuperer la photo
  Future<String> ajouterPhoto(File file, Reference ref) async {
    String url;
    //Creation d'une tache d'upload du fichier
    UploadTask uploadTask = ref.putFile(file);
    //Quand cette tache est terminée, je recupère le lien de téléchargement
    url = await (await uploadTask)
        .ref
        .getDownloadURL()
        .catchError((onError) => print(onError));
    // uploadTask.whenComplete(() async => url =
    //     await ref.getDownloadURL().catchError((onError) => print(onError)));
    return url;
  }

  ///Méthode permettant la modification de la photo
  modificationPhoto(File file) {
    Reference refStockage =
        stockageUitilisateur.child(cUtilisateurConnecte.uid);
    ajouterPhoto(file, refStockage).then((value) {
      Map<String, dynamic> data = {cKeyImageUrl: value};
      modificationDonneeUtilisateur(data);
    });
  }

  ///Ajoute ou supprime un autre utilisateur dans la liste des personnes à suivre et ajoute ou supprime l'utilisateur connecté de la liste des abonnés de l'autre utilisateur
  suivreUtilisateur(Utilisateur autreUtilisateur) {
    //Retrait d'un autre utilisateur de la liste des personnes suivies si présent dans la liste d'abonnement de l'utilisateur connecté
    if (cUtilisateurConnecte.abonnementList.contains(autreUtilisateur.uid)) {
      cUtilisateurConnecte.documentReference.update({
        cKeyAbonnementList: FieldValue.arrayRemove([autreUtilisateur.uid])
      });
      //Par consequent retrait de l'utilisateur connecté egalement de la liste des personnes suivies (abonnés) de l'autre utilisateur
      autreUtilisateur.documentReference.update({
        cKeyAbonnes: FieldValue.arrayRemove([cUtilisateurConnecte.uid])
      });
    } else {
      //sinon je l'ajoute à la liste des personnes à suivre
      cUtilisateurConnecte.documentReference.update({
        cKeyAbonnementList: FieldValue.arrayUnion([autreUtilisateur.uid])
      });
      autreUtilisateur.documentReference.update({
        cKeyAbonnes: FieldValue.arrayUnion([cUtilisateurConnecte.uid])
      });
      // Lorsque qu'une personne presse le bouton suivre alors j'informe l'utilisateur suivi de cette abonnement
      ajouterNotification(
          cUtilisateurConnecte.uid,
          autreUtilisateur.uid,
          "${cUtilisateurConnecte.nom} a commencé à vous suivre",
          cUtilisateurConnecte.documentReference,
          cKeyAbonnes);
    }
  }

  /// Permettre d'ajouter ou de supprimer des posts à la listes des likes pour l'utilisateur connecté
  ajouterLike(Post post) {
    if (post.likes.contains(cUtilisateurConnecte.uid)) {
      post.documentReference.update({
        cKeyLikes: FieldValue.arrayRemove([cUtilisateurConnecte.uid])
      });
    } else {
      post.documentReference.update({
        cKeyLikes: FieldValue.arrayUnion([cUtilisateurConnecte.uid])
      });
      ajouterNotification(
          cUtilisateurConnecte.uid,
          post.postId,
          "${cUtilisateurConnecte.nom} a aimé votre post",
          post.documentReference,
          cKeyLikes);
    }
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
        fireStore_collectionUtilisateurs
            .doc(utilisateurId)
            .collection("posts")
            .doc()
            .set(donneesDuPost);
      });
    } else {
      //Dans tous les cas je cree une collection pour un 'post ' lié à un utilisateur.
      fireStore_collectionUtilisateurs
          .doc(utilisateurId)
          .collection("posts")
          .doc()
          .set(donneesDuPost);
    }
  }

  ///Permet d'ajouter un commentaire pour un post.

  addCommentaire(
      DocumentReference postReference, String texte, String postProprietaire) {
    Map<dynamic, dynamic> map = {
      cKeyUtilisateurId: cUtilisateurConnecte.uid,
      cKeyTexte: texte,
      cKeyDate: DateTime.now().millisecondsSinceEpoch.toInt()
    };
    postReference.update({
      cKeyCommentaires: FieldValue.arrayUnion([map])
    });
    ajouterNotification(
        cUtilisateurConnecte.uid,
        postProprietaire,
        "${cUtilisateurConnecte.nom} a commenté votre post",
        postReference,
        cKeyCommentaires);
  }

  ///Cette methode retourne la liste des posts pour un utilisateur
  Stream<QuerySnapshot> getUserPostsFrom(String uid) =>
      fireStore_collectionUtilisateurs.doc(uid).collection("posts").snapshots();
}
