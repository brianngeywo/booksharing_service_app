import 'package:booksharing_service_app/models/book.dart';
import 'package:booksharing_service_app/models/user_model.dart';

class NotificationClass {
  String id;
  String message;
  DateTime time;
  Book book;
  bool opened;
  UserModel requester;

  NotificationClass({
    required this.id,
    required this.message,
    required this.time,
    required this.book,
    required this.opened,
    required this.requester,
  });
}
