import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;

  User? userApp;
  bool isLoading = true;

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      userApp = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  _getUser() {
    userApp = _auth.currentUser;
    notifyListeners();
  }

  registerUser(String email, String senha) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException('A senha é muito fraca!');
      }

      if (e.code == 'email-already-in-use') {
        throw AuthException('Este email já está cadastrado!');
      }

      throw e.code;
    }
  }

  loginUser(String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('Email não encontrado!');
      }

      if (e.code == 'wrong-password') {
        throw AuthException('Senha incorreta. Tente novamente!');
      }

      if (e.code == 'invalid-email') {
        throw AuthException('Email inválido!');
      }

      throw e.code;
    }
  }

  logoutUser() async {
    await _auth.signOut();
    _getUser();
  }
}
