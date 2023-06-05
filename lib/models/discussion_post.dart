import 'package:booksharing_service_app/models/comment.dart';
import 'package:booksharing_service_app/models/user_model.dart';

class DiscussionPost {
  String id;
  String title;
  UserModel author;
  String content;
  DateTime date;
  List<Comment> comments;

  DiscussionPost({
    required this.id,
    required this.title,
    required this.author,
    required this.content,
    required this.date,
    required this.comments,
  });
}
