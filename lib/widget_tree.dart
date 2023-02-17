import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:song_book/user/start_page.dart';

import 'home_page.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const HomePage(title: "");
        } else {
          return const StartPage();
        }
      },
    );
  }
}