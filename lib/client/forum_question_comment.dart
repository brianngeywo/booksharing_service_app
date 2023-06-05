import 'package:booksharing_service_app/models/user_model.dart';

class ForumQuestionComment {
  final String id;
  final String comment;
  final UserModel postedBy;
  final List<UserModel> upvotes;
  final List<UserModel> downvotes;

  ForumQuestionComment({
    required this.id,
    required this.comment,
    required this.postedBy,
    required this.upvotes,
    required this.downvotes,
  });
}
