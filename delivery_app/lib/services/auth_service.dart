import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? usuario;
  bool isLoading = true;

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      usuario = user == null ? null : user;
      isLoading = false;

      notifyListeners();
    });
  }

  login(String email, String senha) async {
    print('entrou no login');
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      print('deu pau ${e.message}');
      if (e.code == 'invalid-credential') {
        throw AuthException(
            'As credênciais fornecidas são inválidas. Cadastre-se!');
      }
    }
  }

  register(String email, String senha) async {
    print('entrou no register');
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      print('deu pau ${e.code}');
      if (e.code == 'weak-password') {
        throw AuthException('A senha é muito fraca');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('Este email já está cadastrado');
      }
    }
  }

  _getUser() {
    usuario = _auth.currentUser;
    notifyListeners();
  }

  logout() async {
    await _auth.signOut();
    _getUser();
  }
}



/*
  loginWithGoogle() async {
    print('logar com o google');
    try {
      // Inicie o fluxo de login do Google
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      // Se o login for bem-sucedido, obtenha as credenciais de autenticação
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication? googleSignInAuthentication =
            await googleSignInAccount.authentication;

        // Use as credenciais de autenticação para entrar no Firebase
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication?.accessToken,
          idToken: googleSignInAuthentication?.idToken,
        );

        // Entre no Firebase
        await _auth.signInWithCredential(credential);
        //return user;
      }
      _getUser();
    } catch (error) {
      print('Erro ao entrar com o Google: ${error.toString()}');
    }
  }*/