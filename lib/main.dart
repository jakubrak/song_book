import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:song_book/authentication.dart';
import 'package:song_book/firebase_authentication_wrapper.dart';
import 'package:song_book/widget_tree.dart';


Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Authentication authentication = FirebaseAuthenticationWrapper();

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: WidgetTree(authentication)
    ),
  );
}
