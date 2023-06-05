import 'dart:math';

import 'package:booksharing_service_app/models/comment.dart';
import 'package:booksharing_service_app/constants.dart';
import 'package:booksharing_service_app/models/discussion_post.dart';
import 'package:booksharing_service_app/test_datas.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class PostDetailsPage extends StatefulWidget {
  DiscussionPost post;

  PostDetailsPage({super.key, required this.post});

  @override
  _PostDetailsPageState createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  // Controller for the comment text field
  final _commentController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.title,
            style: TextStyle(
              color: textColor,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Posted by ${widget.post.author} on ${DateFormat.yMMMd().format(widget.post.date)}',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    widget.post.content,
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.post.comments.length} Comments',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(height: 16.0),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.post.comments.length,
                    itemBuilder: (context, index) {
                      final comment = widget.post.comments[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${comment.author.name} on ${DateFormat.yMMMd().format(comment.date)}',
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 8.0),
                          Text(comment.content),
                          SizedBox(height: 16.0),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'Add a comment...',
                    ),
                    onSubmitted: (value) {
                      // Add the comment to the list
                      setState(() {
                        widget.post.comments.add(
                          Comment(
                              author: test_users[
                                  1], // Replace with the actual user name
                              content: value,
                              date: DateTime.now(),
                              id: const Uuid().v4(),
                              book: test_books[
                                  Random().nextInt(test_books.length)]),
                        );
                      });

                      // Clear the text field
                      _commentController.clear();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
