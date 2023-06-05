import 'package:booksharing_service_app/models/book.dart';
import 'package:booksharing_service_app/constants.dart';
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  Book book;

  BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(7.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(3),
            height: 150.0,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5)),
              image: DecorationImage(
                image: NetworkImage(book.coverUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8),
            child: Text(
              "Title: ${book.title}",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 8),
            child: Text(
              "Author: ${book.author}",
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 8),
            child: Text(
              "Genre: ${book.genre.name}",
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
