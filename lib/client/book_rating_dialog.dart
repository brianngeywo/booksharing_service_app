import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BookRatingDialog extends StatefulWidget {
  @override
  _BookRatingDialogState createState() => _BookRatingDialogState();
}

class _BookRatingDialogState extends State<BookRatingDialog> {
  double _rating = 0.0;
  String _comment = '';

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Rate this book'),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              RatingBar.builder(
                initialRating: _rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Leave a comment',
                ),
                onChanged: (value) {
                  setState(() {
                    _comment = value;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  // Code to save rating and comment
                  Navigator.of(context).pop();
                },
                child: const Text('Rate'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
