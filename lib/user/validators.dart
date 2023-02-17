String? validateEmail(final String? email) {
  if (email == null || email.isEmpty) {
    return null;
  }

  final tokens = email.split("@");

  if (email.length < 6 || !email.contains("@", 1) || !RegExp(r"^[a-zA-Z0-9!#$%&\'*+\/=?^_`{|}~\.-]+$").hasMatch(tokens[0])) {
    return 'Niepoprawny e-mail';
  }

  return null;
}

String? validatePassword(final String? password) {
  if (password == null || password.isEmpty) {
    return null;
  }

  // Firebase requirement (https://firebase.google.com/docs/reference/android/com/google/firebase/auth/FirebaseAuthWeakPasswordException)
  if (password.length < 6) {
    return 'Za krótkie hasło';
  }

  return null;
}
