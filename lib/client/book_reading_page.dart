import 'dart:math';

import 'package:booksharing_service_app/models/book.dart';
import 'package:booksharing_service_app/client/book_rating_dialog.dart';
import 'package:booksharing_service_app/constants.dart';
import 'package:booksharing_service_app/models/notification.dart';
import 'package:booksharing_service_app/client/rating_widget.dart';
import 'package:booksharing_service_app/services/auth_service.dart';
import 'package:booksharing_service_app/services/user_service.dart';
import 'package:booksharing_service_app/test_datas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:uuid/uuid.dart';

class BookReadingPage extends StatefulWidget {
  Book book;

  BookReadingPage({Key? key, required this.book}) : super(key: key);

  @override
  _BookReadingPageState createState() => _BookReadingPageState();
}

class _BookReadingPageState extends State<BookReadingPage> {
  String borrow_book_button_text = "Borrow this book";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.book.allowedUsers
        .where((element) => element.id == myCurrentUser.id)
        .isNotEmpty) {
      for (var element in widget.book.allowedUsers) {
        print(element.name);
      }
      setState(() {
        borrow_book_button_text = "Download Book";
      });
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
            UserService().borrowBook(widget.book.id);
            if (widget.book.allowedUsers
                .where((element) => element.id == myCurrentUser.id)
                .isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Starting download...",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  duration: Duration(seconds: 2),
                  backgroundColor: Colors.green,
                ),
              );
            } else {
              //add new notification
              test_notifications.add(NotificationClass(
                id: Uuid().v4(),
                message: '${widget.book.title} borrow request',
                time: DateTime.now(),
                book: widget.book,
                opened: false,
                requester: myCurrentUser,
              ));
              for (var element in widget.book.allowedUsers) {
                print(element.name);
              }
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Request sent successfully!",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  duration: Duration(seconds: 2),
                  backgroundColor: Colors.green,
                ),
              );
              setState(() {
                borrow_book_button_text = "Pending approval";
              });
            }
          },
          child: Container(
            height: 30,
            margin: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                borrow_book_button_text,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(
          widget.book.title,
          style: TextStyle(
            color: textColor,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.share_outlined,
              color: textColor,
            ),
            onPressed: () {
              // Share the book on social media.
            },
          ),
          const SizedBox(width: 10),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.book.title,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6.0),
                Text(
                  widget.book.author,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(height: 6.0),
                Text(
                  widget.book.genre.name,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(height: 8.0),
                my_divider,
                const SizedBox(height: 8.0),
                Text(
                  "Abstract",
                  style: TextStyle(
                    fontSize: 20,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  widget.book.description,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: my_divider,
          ),
          const SizedBox(height: 8.0),
          MyRatingWidget(
            ratings: test_ratings,
            currentUser: test_users[1],
            book: widget.book,
          ),
          // const SizedBox(height: 16.0),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
