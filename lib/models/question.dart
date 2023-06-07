import 'package:booksharing_service_app/models/forum_question_comment.dart';
import 'package:booksharing_service_app/models/book.dart';
import 'package:booksharing_service_app/models/user_model.dart';

class Question {
  String id;
  String title;
  String body;
  Book? attachedBook;
  UserModel postedBy;
  List<ForumQuestionComment> forumComments;
  DateTime timeUploaded;

  Question({
    required this.id,
    required this.title,
    required this.body,
    this.attachedBook,
    required this.postedBy,
    required this.forumComments,
    required this.timeUploaded,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'attachedBook': attachedBook?.toMap(),
      'postedBy': postedBy.toMap(),
      'forumComments': forumComments.map((comment) => comment.toMap()).toList(),
      'timeUploaded': timeUploaded,
    };
  }

  static Question fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'],
      title: map['title'],
      body: map['body'],
      attachedBook: Book.fromMap(map['attachedBook']),
      postedBy: UserModel.fromMap(map['postedBy']),
      forumComments: (map['forumComments'] as List<dynamic>)
          .map((comment) => ForumQuestionComment.fromMap(comment))
          .toList(),
      timeUploaded: map['timeUploaded'].toDate(),
    );
  }
}
