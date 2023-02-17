import 'package:flutter/material.dart';
import 'package:song_book/authentication.dart';
import 'package:song_book/user/forgot_page.dart';
import 'package:song_book/user/login_page.dart';
import 'package:song_book/user/register_page.dart';

class StartPage extends StatelessWidget {
  const StartPage(this.authentication, {super.key});

  final Authentication authentication;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                alignment: Alignment.bottomCenter,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      MaterialButton(
                          shape: const BeveledRectangleBorder(),
                          color: Theme.of(context).primaryColorDark,
                          textColor: Colors.white70,
                          padding: const EdgeInsets.all(16.0),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage(authentication)));
                          },
                          child: const Text('Utwórz konto')),
                      const SizedBox(height: 10),
                      MaterialButton(
                          shape: const BeveledRectangleBorder(),
                          color: Colors.white,
                          textColor: Colors.black87,
                          padding: const EdgeInsets.all(16.0),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(authentication)));
                          },
                          child: const Text('Logowanie')),
                      TextButton(
                        child: const Text('Przypomnij hasło',
                            style: TextStyle(
                              color: Colors.white70,
                            )),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordPage(authentication)));
                        },
                      ),
                    ]))));
  }
}
