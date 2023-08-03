import 'package:firebase_auth/firebase_auth.dart';

enum AuthenticationStatus {
  LOADING,
  ANONYMOUS,
  LOGGED_IN,
}

abstract class Authentication {
  Future<String> signUp(String email, String password);

  Future<User> signIn(String email, String password);

  Future<void> signOut();

  Future<void> sendEmailVerification();

  Future<bool> isEmailVerified();

  Future<User> getCurrentUser();
}

class FirebaseEmailAuthentication implements Authentication {
  FirebaseAuth _auth;

  FirebaseEmailAuthentication({FirebaseAuth? firebaseAuth})
      : _auth = firebaseAuth ?? FirebaseAuth.instance;

  Future<String> signUp(String email, String password) async {
    var result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    var user = result.user;

    return user!.uid;
  }

  Future<User> signIn(String email, String password) async {
    var result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user!;
  }

  Future<void> signOut() async {
    return _auth.signOut();
  }

  Future<void> sendEmailVerification() async {
    var user = _auth.currentUser;
    user!.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    var user = _auth.currentUser;
    return user!.emailVerified;
  }

  Future<User> getCurrentUser() async {
    var user = _auth.currentUser;
    return user!;
  }
}
