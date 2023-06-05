import 'package:booksharing_service_app/models/book.dart';
import 'package:booksharing_service_app/models/user_model.dart';

class Comment {
  String id;
  UserModel author;
  String content;
  DateTime date;
  Book book;

  Comment({
    required this.id,
    required this.author,
    required this.content,
    required this.date,
    required this.book,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'author': author.toMap(),
      'content': content,
      'date': date.toString(),
      'book': book,
    };
  }

  static Comment fromMap(Map<String, dynamic> map) {
    return Comment(
        id: map['id'],
        author: UserModel.fromMap(map['author']),
        content: map['content'],
        date: DateTime.parse(map['date']),
        book: Book.fromMap(map['book']));
  }
}
