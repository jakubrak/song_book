import 'package:flutter/material.dart';
import 'package:song_book/authentication.dart';
import 'package:song_book/user/validators.dart';

import 'login_page_template.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage(this.authentication, {super.key});

  final Authentication authentication;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String? validatePasswordConfirmation(final String? password) {
    if (password == null || password.isEmpty) {
      return null;
    }

    if (password != passwordController.text) {
      return "Hasła nie są identyczne";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return LoginPageTemplate(
      title: "Witaj",
      subtitle: "Podaj swój e-mail i hasło",
      submitText: "Utwórz konto",
      onSubmit: () async {
        await widget.authentication.signUpWithEmailAndPassword(
            emailController.text, passwordController.text);
      },
      onSubmitDone: () async {
        await Future.delayed(const Duration(seconds: 1));
        if (!mounted) return;
        Navigator.of(context).pop();
      },
      children: [
        TextFormField(
          decoration: const InputDecoration(hintText: 'E-mail'),
          validator: validateEmail,
          controller: emailController,
        ),
        TextFormField(
          decoration: const InputDecoration(hintText: 'Hasło'),
          obscureText: true,
          validator: validatePassword,
          controller: passwordController,
        ),
        TextFormField(
          decoration: const InputDecoration(hintText: 'Powtórz hasło'),
          obscureText: true,
          validator: validatePasswordConfirmation,
          controller: confirmPasswordController,
        )
      ],
    );
  }
}
