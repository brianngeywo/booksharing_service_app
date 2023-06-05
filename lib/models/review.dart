import 'book.dart';
import 'user_model.dart';

class Review {
  Book book;
  UserModel user;
  int rating;
  String comment;

  Review({
    required this.book,
    required this.user,
    required this.rating,
    required this.comment,
  });
}
