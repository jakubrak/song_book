import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:song_book/user/validators.dart';

import 'login_page_template.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return LoginPageTemplate(
        title: "Witaj ponownie",
        subtitle: "Podaj nazwę użytkownika i hasło aby się zalogować",
        submitText: "Zaloguj",
        children: [
          TextFormField(
            decoration: const InputDecoration(hintText: 'E-mail'),
            validator: validateEmail,
            controller: emailController,
          ),
          TextFormField(
            decoration: const InputDecoration(
                hintText: 'Hasło'
            ),
            obscureText: true,
            controller: passwordController,
          )
        ],
        onSubmit: () async {
          try {
            await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: emailController.text,
                password: passwordController.text
            );
          } on FirebaseAuthException catch (e) {
            if (e.code == 'user-not-found') {
              print('No user found for that email.');
            } else if (e.code == 'wrong-password') {
              print('Wrong password provided for that user.');
            }
          }
          if (!mounted) return;
          Navigator.of(context).pop();
        }
    );
  }
}
