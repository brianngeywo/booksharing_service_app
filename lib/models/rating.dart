import 'package:booksharing_service_app/models/discussion_post_comment.dart';
import 'package:booksharing_service_app/models/user_model.dart';

class Rating {
  int stars;
  DiscussionPostComment comment;
  UserModel user;

  Rating({
    required this.user,
    required this.stars,
    required this.comment,
  });

  // Convert object to a map
  Map<String, dynamic> toMap() {
    return {
      'stars': stars,
      'comment': comment.toMap(),
      'user': user.toMap(),
    };
  }

  // Create object from a map
  static Rating fromMap(Map<String, dynamic> map) {
    return Rating(
      stars: map['stars'],
      comment: DiscussionPostComment.fromMap(map['comment']),
      user: UserModel.fromMap(map['user']),
    );
  }
}
