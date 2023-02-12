import 'package:flutter/material.dart';
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
      onSubmit: () {},
      children: [
        TextFormField(
          decoration: const InputDecoration(
            hintText: 'E-mail',
          ),
          controller: emailController,
        )
      ],
    );
  }
}
