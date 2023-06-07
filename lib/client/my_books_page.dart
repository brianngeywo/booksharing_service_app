import 'package:booksharing_service_app/client/book_reading_page.dart';
import 'package:booksharing_service_app/models/book.dart';
import 'package:booksharing_service_app/constants.dart';
import 'package:booksharing_service_app/services/book_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'book_card.dart';

class MyBooksPage extends StatefulWidget {
  @override
  _MyBooksPageState createState() => _MyBooksPageState();
}

class _MyBooksPageState extends State<MyBooksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Books',
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
      body: Center(
        child: FutureBuilder<List<Book>>(
          future: BookService().getBooks(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final uploadedBooks = snapshot.data!;
              return ListView(
                children: uploadedBooks.map((book) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BookReadingPage(book: book)));
                    },
                    child: BookCard(book: book),
                  );
                }).toList(),
              );
            } else if (snapshot.hasError) {
              return Text('Error fetching books: ${snapshot.error}');
            }
            return CircularProgressIndicator(); // Show a loading indicator while fetching data
          },
        ),
      ),
    );
  }
}
