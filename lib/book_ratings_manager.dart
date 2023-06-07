import 'dart:async';

import 'package:booksharing_service_app/models/discussion_post_comment.dart';
import 'package:booksharing_service_app/models/rating.dart';

class BookRatingsManager {
  StreamController<List<Rating>> _ratingsController =
      StreamController<List<Rating>>.broadcast();
  Stream<List<Rating>> get ratingsStream => _ratingsController.stream;

  StreamController<List<DiscussionPostComment>> _commentsController =
      StreamController<List<DiscussionPostComment>>.broadcast();
  Stream<List<DiscussionPostComment>> get commentsStream =>
      _commentsController.stream;

  List<Rating> _ratings = [];
  List<DiscussionPostComment> _comments = [];

  void addRating(Rating rating) {
    _ratings.add(rating);
    _ratingsController.add(_ratings);
  }

  void addComment(DiscussionPostComment comment) {
    _comments.add(comment);
    _commentsController.add(_comments);
  }

  void dispose() {
    _ratingsController.close();
    _commentsController.close();
  }
}
