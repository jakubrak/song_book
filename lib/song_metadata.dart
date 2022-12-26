class SongMetadata {
  SongMetadata({
    required this.title,
    required this. author,
    required this.id
  });

  factory SongMetadata.fromJson(Map<String, dynamic> json) =>
      SongMetadata(
        title: json['title'],
        author: json['author'],
        id: json['id'],
      );

  final String title;
  String author;
  String id;
}
