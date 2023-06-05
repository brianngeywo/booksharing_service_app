import 'package:booksharing_service_app/models/book.dart';
import 'package:booksharing_service_app/models/user_model.dart';

class Question {
  String id;
  String title;
  String body;
  Book? attachedBook;
  UserModel postedBy;
  List<UserModel> upvotes;
  List<UserModel> downvotes;
  DateTime timeUploaded;

  Question({
    required this.id,
    required this.title,
    required this.body,
    this.attachedBook,
    required this.postedBy,
    required this.upvotes,
    required this.downvotes,
    required this.timeUploaded,
  });
}
