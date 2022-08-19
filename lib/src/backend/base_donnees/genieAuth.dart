import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:genie/src/backend/base_donnees/firebase_personnel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modeles/personnel.dart';


class GenieAuthService {
  // Avec email et password
  static FirebaseAuth auth = FirebaseAuth.instance;

  static Stream<User?> get authStateChanges => auth.authStateChanges();

  static bool isAuth() {
    return auth.currentUser != null;
  }

  static Future<String> createUserWithEmailAndPassword(
      {required String email,
        required String password,
        required String name,
        required TypePersonnel type
      }) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await storeUser(auth.currentUser!, name, type);
      return "signup";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return "Mot de passe trop faible";
      } else if (e.code == 'email-already-in-use') {
        return "Un compte existe déjà avec ce mail";
      }
    } catch (e) {
      //return "Inscription échouée";
      await auth.signOut();
      return e.toString();
    }

    return "Inscription échouée";

    /*on FirebaseAuthException catch (e) {
      print(e.message);
      return e.message!;
    }*/
  }

  static Future<String> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);

      return "signin";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "Aucun utilisateur avec cet émail";
      }
      else if (e.code == 'wrong-password') {
        return "Mot de passe incorrect";
      }
      return e.message.toString();
    } catch (e) {
      await auth.signOut();
      return e.toString();
    }
    return "Connexion échouée7";
  }

  static Future storeUser(User u, String name, TypePersonnel type) async {
    Personnel personnel = Personnel(uid: u.uid, id: '', nom: name, email: u.email!, type: type);

    await FirebasePersonnel.addPersonnel(personnel);

  }
}