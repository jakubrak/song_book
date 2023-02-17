class SongMetadata {
  SongMetadata({
    required this.title,
    required this. author,
    required this.id
  });

  factory SongMetadata.fromJson(Map<String, dynamic> json) =>
      SongMetadata(
        title: json['title'].toString().trim(),
        author: json['author'].toString().trim(),
        id: json['id'].toString().trim(),
      );

  final String title;
  final String author;
  final String id;
}
