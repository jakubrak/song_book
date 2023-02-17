import 'package:firebase_auth/firebase_auth.dart';
import 'package:song_book/authentication.dart';

class FirebaseAuthenticationWrapper implements Authentication {
  final firebaseAuth = FirebaseAuth.instance;

  String codeToMessage(final String code) {
    final messages = {
      'user-not-found' : 'No user found for that email',
      'user-disabled' : 'User is blocked',
      'email-already-in-use' : 'The account already exists for that email',
      'invalid-email' : 'The email address is not valid',
      'wrong-password' : 'Wrong password provided for that user',
      'weak-password' : 'The password provided is too weak',
      'too-many-requests' : 'Too many failed attempts, you need to wait a while',
      'operation-not-allowed' : 'Authentication with email and password is not enabled',
    };

    return messages.containsKey(code) ? messages[code]! : "Unknown error: $code";
  }

  @override
  Future signUpWithEmailAndPassword(final String email, final String password) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthenticationException(codeToMessage(e.code));
    }
  }

  @override
  Future signInWithEmailAndPassword(final String email, final String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseAuthException catch (e) {
      throw AuthenticationException(codeToMessage(e.code));
    }
  }

  @override
  Future sendPasswordResetEmail(final String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    }  on FirebaseAuthException catch (e) {
      throw AuthenticationException(codeToMessage(e.code));
    }
  }
}