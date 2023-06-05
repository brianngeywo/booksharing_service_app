import 'package:booksharing_service_app/client/book_reading_page.dart';
import 'package:booksharing_service_app/models/book.dart';
import 'package:booksharing_service_app/constants.dart';
import 'package:booksharing_service_app/services/book_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyBooksPage extends StatefulWidget {
  @override
  _MyBooksPageState createState() => _MyBooksPageState();
}

class _MyBooksPageState extends State<MyBooksPage> {
  bool _isUploadedExpanded = false;
  bool _isBorrowedExpanded = true;

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  _isUploadedExpanded = !_isUploadedExpanded;
                });
              },
              children: [
                ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      leading: Icon(
                        Icons.library_books,
                        color: textColor,
                      ),
                      title: Text(
                        'Uploaded Books',
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                    );
                  },
                  body: FutureBuilder<List<Book>>(
                    future: BookService().getBooks(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final uploadedBooks = snapshot.data!;
                        return SingleChildScrollView(
                          child: Column(
                            children: uploadedBooks.map((book) {
                              return ListTile(
                                leading: ClipRRect(
                                  child: Image.network(
                                    book.coverUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: Text(book.title),
                                subtitle: Text(book.author),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BookReadingPage(book: book)));
                                },
                              );
                            }).toList(),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error fetching books: ${snapshot.error}');
                      }
                      return CircularProgressIndicator(); // Show a loading indicator while fetching data
                    },
                  ),
                  isExpanded: _isUploadedExpanded,
                ),
              ],
            ),
            // ... Remaining code for borrowed books expansion panel ...
          ],
        ),
      ),
    );
  }
}
