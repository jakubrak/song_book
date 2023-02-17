class AuthenticationException implements Exception {
  AuthenticationException(this.message);

  String message;
}

abstract class Authentication {
  Future signUpWithEmailAndPassword(final String email, final String password);
  Future signInWithEmailAndPassword(final String email, final String password);
  Future sendPasswordResetEmail(final String email);
}