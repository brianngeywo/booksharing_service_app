import 'dart:math';

import 'package:booksharing_service_app/services/borrow_book_service.dart';
import 'package:booksharing_service_app/models/book.dart';
import 'package:booksharing_service_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BookReadingPage extends StatefulWidget {
  Book book;

  BookReadingPage({Key? key, required this.book}) : super(key: key);

  @override
  _BookReadingPageState createState() => _BookReadingPageState();
}

class _BookReadingPageState extends State<BookReadingPage> {
  String borrowBookButtonText = "Download this book";

  @override
  void initState() {
    super.initState();
  }

  Future<void> _launchFileUrl() async {
    if (widget.book.fileUrl != null && widget.book.fileUrl!.isNotEmpty) {
      if (await canLaunch(widget.book.fileUrl!)) {
        await launch(widget.book.fileUrl!);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Failed to open file",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.redAccent,
            closeIconColor: Colors.white,
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(textColor),
          ),
          onPressed: () {
            // Borrow a book
            BorrowBookService().borrowBook(
                widget.book.id, '6ffeb1ba-257f-46fb-a260-86334baef9a6');

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "File will be downloaded shortly!",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                duration: Duration(seconds: 2),
                backgroundColor: Colors.green,
              ),
            );
            _launchFileUrl();
          },
          child: Container(
            height: 30,
            margin: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                borrowBookButtonText,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(
          widget.book.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                _launchFileUrl();
              },
              icon: Icon(
                Icons.download,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  widget.book.coverUrl,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              widget.book.title.toUpperCase(),
              style: TextStyle(
                color: textColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 6.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              widget.book.author,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          const SizedBox(height: 6.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              widget.book.genre.name,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: my_divider,
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Abstract",
              style: TextStyle(
                fontSize: 20,
                color: textColor,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          my_divider,
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              widget.book.description,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: my_divider,
          ),
        ],
      ),
    );
  }
}
