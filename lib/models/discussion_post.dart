import 'package:booksharing_service_app/models/discussion_post_comment.dart';
import 'package:booksharing_service_app/models/genre.dart';
import 'package:booksharing_service_app/models/user_model.dart';

class DiscussionPost {
  String id;
  String title;
  UserModel author;
  String content;
  DateTime date;
  List<DiscussionPostComment> comments;
  Genre genre;

  DiscussionPost({
    required this.id,
    required this.title,
    required this.author,
    required this.content,
    required this.date,
    required this.comments,
    required this.genre,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author.toMap(),
      'content': content,
      'date': date.toString(),
      'comments': comments.map((comment) => comment.toMap()).toList(),
      'genre': genre.toMap(),
    };
  }

  static DiscussionPost fromMap(Map<String, dynamic> map) {
    return DiscussionPost(
      id: map['id'],
      title: map['title'],
      author: UserModel.fromMap(map['author']),
      content: map['content'],
      date: DateTime.parse(map['date']),
      comments: (map['comments'] as List<dynamic>)
          .map((commentData) => DiscussionPostComment.fromMap(commentData))
          .toList(),
      genre: Genre.fromMap(map['genre']),
    );
  }
}
