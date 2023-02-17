import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:song_book/user/validators.dart';

import '../home_page.dart';
import 'login_page_template.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

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

  Future signUp() async {
    try {
      await Future.delayed(const Duration(seconds: 3));

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }



  @override
  Widget build(BuildContext context) {
    return LoginPageTemplate(
      title: "Witaj",
      subtitle: "Podaj swój e-mail i hasło",
      submitText: "Utwórz konto",
      onSubmit: signUp,
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
