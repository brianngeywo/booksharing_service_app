import 'package:booksharing_service_app/models/user_model.dart';

class Message {
  int id;
  UserModel sender;
  String content;
  DateTime time;

  Message({
    required this.id,
    required this.sender,
    required this.content,
    required this.time,
  });
}
