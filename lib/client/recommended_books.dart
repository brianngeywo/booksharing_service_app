import 'package:booksharing_service_app/client/book_card.dart';
import 'package:booksharing_service_app/client/book_reading_page.dart';
import 'package:booksharing_service_app/client/spinning_widget.dart';
import 'package:booksharing_service_app/constants.dart';
import 'package:booksharing_service_app/models/book.dart';
import 'package:booksharing_service_app/services/book_service.dart';
import 'package:booksharing_service_app/static_datas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RecommendedBooks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recommended Books',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
      ),
      body: FutureBuilder<List<Book>>(
        future: BookService().getBooks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinningWidget(),
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(
              child: Text('No data found'),
            );
          }
          final data = snapshot.data!;

          return ListView(
            children: data
                .map((book) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => BookReadingPage(
                              book: book,
                            ),
                          ),
                        ),
                        child: BookCard(book: book),
                      ),
                    ))
                .toList(),
          );
        },
      ),
    );
  }
}
