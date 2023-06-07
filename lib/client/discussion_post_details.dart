import 'dart:math';

import 'package:booksharing_service_app/models/discussion_post_comment.dart';
import 'package:booksharing_service_app/constants.dart';
import 'package:booksharing_service_app/models/discussion_post.dart';
import 'package:booksharing_service_app/services/discussion_group_service.dart';
import 'package:booksharing_service_app/static_datas.dart';
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
  List<DiscussionPostComment> _comments = [];
  @override
  void initState() {
    // TODO: implement initState
    fetchComments();
    super.initState();
  }

  fetchComments() async {
    try {
      List<DiscussionPostComment> comments =
          await DiscussionGroupService().fetchComments(widget.post.id);
      setState(() {
        _comments = comments;
      });
    } catch (e) {
      print('Failed to fetch forum comments: $e');
    }
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
                    widget.post.title,
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Posted by ${widget.post.author.name} on ${formatter.format(widget.post.date)}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    widget.post.content,
                    style: const TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            ),
            // my_divider,
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                minLines: 7,
                maxLines: 250,
                textAlignVertical: TextAlignVertical.top,
                controller: _commentController,
                style: const TextStyle(color: Colors.white), // Set text color
                decoration: InputDecoration(
                  hintText: 'Add a comment...',
                  filled: true,
                  fillColor: Colors.grey[800], // Set background color
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 16.0),
                  hintStyle:
                      TextStyle(color: Colors.grey[400]), // Set hint text color
                ),
              ),
            ),
            const SizedBox(height: 10.0),

            Container(
              decoration: BoxDecoration(
                color: Colors.blue, // Set button color
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
              margin: const EdgeInsets.only(left: 16),
              child: GestureDetector(
                onTap: () {
                  // Add the comment to the list
                  DiscussionPostComment comment = DiscussionPostComment(
                    author: test_user, // Replace with the actual user name
                    content: _commentController.text,
                    date: DateTime.now(),
                    id: const Uuid().v4(),
                  );
                  DiscussionGroupService().addComment(widget.post.id, comment);

                  // Clear the text field
                  _commentController.clear();
                },
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                  child: Text(
                    'Send',
                    style: TextStyle(
                      color: Colors.white, // Set button text color
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16.0),
            my_divider,
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Comments',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  StreamBuilder<List<DiscussionPostComment>>(
                    stream: DiscussionGroupService()
                        .fetchComments(widget.post.id)
                        .asStream(), // Replace `yourCommentStream` with the actual comment stream
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final comments = snapshot.data!;
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: comments.length,
                          itemBuilder: (context, index) {
                            final comment = comments[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${comment.author.name} on ${formatter.format(comment.date)}',
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                const SizedBox(height: 8.0),
                                Text(comment.content),
                                const SizedBox(height: 16.0),
                              ],
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return const Text('Error loading comments');
                      } else {
                        return const CircularProgressIndicator();
                      }
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
