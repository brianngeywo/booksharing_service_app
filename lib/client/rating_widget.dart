import 'package:booksharing_service_app/constants.dart';
import 'package:booksharing_service_app/models/book.dart';
import 'package:booksharing_service_app/models/comment.dart';
import 'package:booksharing_service_app/models/rating.dart';
import 'package:booksharing_service_app/models/user_model.dart';
import 'package:booksharing_service_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class MyRatingWidget extends StatefulWidget {
  List<Rating> ratings;
  UserModel currentUser;
  Book book;

  MyRatingWidget({
    Key? key,
    required this.ratings,
    required this.currentUser,
    required this.book,
  }) : super(key: key);

  @override
  _MyRatingWidgetState createState() => _MyRatingWidgetState();
}

class _MyRatingWidgetState extends State<MyRatingWidget> {
  TextEditingController _commentController = TextEditingController();
  int? _ratingValue;

  void _submitRating() {
    if (_ratingValue == null) {
      return;
    }

    final newComment = Comment(
      id: const Uuid().v4(),
      author: widget.currentUser,
      content: _commentController.text.trim(),
      date: DateTime.now(),
      book: widget.book,
    );

    final newRating = Rating(
      user: widget.currentUser,
      stars: _ratingValue!,
      comment: newComment,
    );

    setState(() {
      widget.ratings.add(newRating);
      _commentController.clear();
      _ratingValue = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tell us your thoughts',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 18,
              color: textColor,
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  minLines: 1,
                  maxLines: 10,
                  controller: _commentController,
                  decoration:
                      const InputDecoration(hintText: 'Leave a comment'),
                ),
              ),
              const SizedBox(width: 8),
              DropdownButton<int>(
                value: _ratingValue,
                hint: const Text('Rate this book'),
                onChanged: (value) {
                  setState(() {
                    _ratingValue = value;
                  });
                },
                items: List.generate(
                  5,
                  (index) => DropdownMenuItem<int>(
                    value: index + 1,
                    child: Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber),
                        const SizedBox(width: 8),
                        Text('${index + 1} stars'),
                      ],
                    ),
                  ),
                ),
              ),
              // const SizedBox(width: 8),
            ],
          ),
          const SizedBox(height: 8),
          MaterialButton(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: textColor,
            onPressed: _submitRating,
            child: const SizedBox(
              height: 35,
              child: Center(
                child: Text(
                  'Post',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Divider(color: textColor),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.ratings.length,
            itemBuilder: (context, index) {
              Rating rating = widget.ratings[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${rating.stars} stars',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'by ${rating.user.name}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(rating.comment.content),
                    const SizedBox(height: 8),
                  ],
                ),
              );
            },
          ),
          // const SizedBox(height: 16),
        ],
      ),
    );
  }
}
