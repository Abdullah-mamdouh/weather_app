


import 'package:firebase_auth/firebase_auth.dart';

import 'exception/auth_exception.dart';

class AuthenticationService {
  static final auth = FirebaseAuth.instance;
  static late AuthStatus _status;


  Future<AuthStatus> createAccount({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential newUser = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      auth.currentUser!.updateDisplayName(name);
      _status = AuthStatus.successful;
    } on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleAuthException(e);
    }
    return _status;
  }

  Future<AuthStatus> login({
    required String email,
    required String password,
  }) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      _status = AuthStatus.successful;
    } on  FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleAuthException(e);
    }
    return _status;
  }

  Future<AuthStatus> updateUserAccount({
    required String email,
    required String password,
    required String name,
  }) async {
    try {

     await auth.currentUser!.updateEmail(email);
     await auth.currentUser!.updatePassword(password);
     await auth.currentUser!.updateDisplayName(name);
     //await auth.currentUser!.reload().then((value) =>  _status = AuthStatus.successful);
     _status = AuthStatus.successful;
    } on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleAuthException(e);
    }
    return _status;
  }

  Future<AuthStatus> resetPassword({required String email}) async {
    await auth
        .sendPasswordResetEmail(email: email)
        .then((value) => _status = AuthStatus.successful)
        .catchError((e) => _status = AuthExceptionHandler.handleAuthException(e));
    return _status;
  }


  Future<void> logout() async {
    await auth.signOut();
  }
}