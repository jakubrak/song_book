import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:song_book/song_book_page.dart';
import 'package:song_book/song_metadata.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MaterialButton(
                  shape: const BeveledRectangleBorder(),
                  color: Theme.of(context).primaryColorDark,
                  textColor: Colors.white70,
                  padding: const EdgeInsets.all(16.0),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const SongBookPage(title: "Song Book")));
                  },
                  child: const Text('Song Book')),
              MaterialButton(
                  shape: const BeveledRectangleBorder(),
                  color: Theme.of(context).primaryColorDark,
                  textColor: Colors.white70,
                  padding: const EdgeInsets.all(16.0),
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                  },
                  child: const Text('Sign out')),
            ],
          )));
}
