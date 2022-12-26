import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:song_book/song_metadata.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final db = FirebaseFirestore.instance;
  static const pageSize = 20;

  Future<List<SongMetadata>> fetchMetadata(int pageKey, int pageSize) async {
    List<SongMetadata> songMetadata = [];
    await db.collection("metadata")
        .get()
        .then(
            (querySnapshot) {
          for (final doc in querySnapshot.docs) {
            songMetadata.add(SongMetadata.fromJson(doc.data()));
          }
        });
    return songMetadata;
  }

  final PagingController<int, SongMetadata> _pagingController =
  PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> fetchPage(int pageKey) async {
    try {

      final newItems = await fetchMetadata(pageKey, pageSize);
      final isLastPage = newItems.length < pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context)  => RefreshIndicator(
    onRefresh: () => Future.sync(
          () => _pagingController.refresh(),
    ),
    child: PagedListView<int, SongMetadata>.separated(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<SongMetadata>(
          animateTransitions: true,
          itemBuilder: (context, item, index) => Container(
            color: Colors.green,
            child: Material(
              child: ListTile(
                title: Text(item.title),
                tileColor: Colors.red,
              ),
            ),
          )
      ),
      separatorBuilder: (context, index) => const Divider(),
    ),
  );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}