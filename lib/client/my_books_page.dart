import 'package:booksharing_service_app/client/book_reading_page.dart';
import 'package:booksharing_service_app/client/spinning_widget.dart';
import 'package:booksharing_service_app/models/book.dart';
import 'package:booksharing_service_app/constants.dart';
import 'package:booksharing_service_app/models/user_model.dart';
import 'package:booksharing_service_app/services/auth_service.dart';
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
  UserModel? _user;

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  void _fetchUserDetails() async {
    UserModel userDetails = await AuthService().getCurrentUser();
    setState(() {
      _user = userDetails;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Books',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
      ),
      body: Center(
        child: FutureBuilder<List<Book>>(
          future: BookService().getBooksByUserId(_user!.id),
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
            return SpinningWidget(); // Show a loading indicator while fetching data
          },
        ),
      ),
    );
  }
}
