import 'package:booksharing_service_app/models/genre.dart';
import 'package:booksharing_service_app/models/user_model.dart';

class BookClub {
  String name;
  String id;
  Genre genre;
  String description;
  List<UserModel> members;

  BookClub({
    required this.id,
    required this.genre,
    required this.description,
    required this.members,
    required this.name,
  });
}
