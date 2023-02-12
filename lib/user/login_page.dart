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
  void initState() {
    super.initState();
  }

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
        onSubmit: () {

        }
    );
  }
}
