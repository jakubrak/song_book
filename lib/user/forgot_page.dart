import 'package:flutter/material.dart';
import 'package:song_book/authentication.dart';
import 'package:song_book/user/validators.dart';
import 'login_page_template.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage(this.authentication, {super.key});

  final Authentication authentication;

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
        await widget.authentication.sendPasswordResetEmail(emailController.text);
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
