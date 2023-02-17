import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:song_book/user/validators.dart';
import 'login_page_template.dart';

class ForgotPasswordPage extends StatefulWidget {
  static String tag = 'forgot-password-page';

  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LoginPageTemplate(
      title: "Odzyskiwanie konta",
      subtitle: "Podaj e-mail powiązany z twoim kontem",
      submitText: 'Wyślij',
      onSubmit: () async {
        try {
          await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            print('No user found for that email.');
          } else if (e.code == 'invalid-email') {
            print('The email address is not valid.');
          }
        }

        if (!mounted) return;
        Navigator.of(context).pop();
      },
      children: [
        TextFormField(
          decoration: const InputDecoration(
            hintText: 'E-mail',
          ),
          validator: validateEmail,
          controller: emailController,
        )
      ],
    );
  }
}
