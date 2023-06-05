import 'package:booksharing_service_app/models/comment.dart';

class Blog {
  int id;
  String title;
  String author;
  String content;
  DateTime date;
  List<Comment> comments;

  Blog({
    required this.id,
    required this.title,
    required this.author,
    required this.content,
    required this.date,
    required this.comments,
  });
}
