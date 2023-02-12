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
