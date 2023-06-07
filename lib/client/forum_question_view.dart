import 'dart:io';
import 'dart:math';

import 'package:booksharing_service_app/models/forum_question_comment.dart';
import 'package:booksharing_service_app/models/book.dart';
import 'package:booksharing_service_app/constants.dart';
import 'package:booksharing_service_app/models/question.dart';
import 'package:booksharing_service_app/services/forum_service.dart';
import 'package:booksharing_service_app/static_datas.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

class ForumQuestionView extends StatefulWidget {
  final Question question;

  ForumQuestionView({required this.question});

  @override
  _ForumQuestionViewState createState() => _ForumQuestionViewState();
}

class _ForumQuestionViewState extends State<ForumQuestionView> {
  final _commentFormKey = GlobalKey<FormState>();
  TextEditingController _commentTextController = TextEditingController();
  List<ForumQuestionComment> forumComments = [];

  @override
  void initState() {
    super.initState();
    fetchForumComments();
  }

  Future<void> fetchForumComments() async {
    try {
      List<ForumQuestionComment> comments =
          await ForumService().fetchForumComments(widget.question.id);
      setState(() {
        forumComments = comments;
      });
    } catch (e) {
      print('Failed to fetch forum comments: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.question.title,
          style: TextStyle(color: textColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.question.title,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 10),
            Text(
              widget.question.body,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            if (widget.question.attachedBook != null)
              AttachedBookWidget(book: widget.question.attachedBook!),
            const SizedBox(height: 20),
            my_divider,
            const SizedBox(height: 20),
            CommentForm(
              formKey: _commentFormKey,
              commentTextController: _commentTextController,
              onSubmit: () {
                if (_commentFormKey.currentState!.validate()) {
                  // Create a new Comment object
                  ForumQuestionComment comment = ForumQuestionComment(
                    id: const Uuid().v4(),
                    comment: _commentTextController.text,
                    postedBy: test_user,
                  );
                  ForumService().addForumComment(widget.question.id, comment);
                  // Add the new comment to the list of forum_comments
                  setState(() {
                    _commentTextController.clear();
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            my_divider,
            const SizedBox(height: 20),
            Text(
              'Comments',
              style: TextStyle(
                fontSize: 20,
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            forumComments.isNotEmpty && forumComments != null
                ? buildCommentsList()
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ],
        ),
      ),
    );
  }

  buildCommentsList() {
    return StreamBuilder<List<ForumQuestionComment>>(
      stream: ForumService().fetchForumComments(widget.question.id).asStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final forumComments = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: forumComments.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "By ${forumComments[index].postedBy.name} ",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        forumComments[index].comment,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Divider(),
                  ],
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

class AttachedBookWidget extends StatelessWidget {
  Book book;

  AttachedBookWidget({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    Future<void> _downloadBook() async {
      if (book!.fileUrl != null && book!.fileUrl!.isNotEmpty) {
        if (await canLaunch(book!.fileUrl!)) {
          await launch(book!.fileUrl!);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Failed to open file",
                style: TextStyle(color: Colors.redAccent),
              ),
              backgroundColor: Colors.red,
              closeIconColor: Colors.white,
              duration: Duration(seconds: 3),
            ),
          );
        }
      }
    }

    return Container(
      decoration: BoxDecoration(
        // border: Border.,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Attached book: ${book.title}',
              style: TextStyle(
                fontSize: 16,
                color: textColor,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.download_rounded),
            onPressed: () {
              _downloadBook();
            },
          ),
        ],
      ),
    );
  }
}

class CommentForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController commentTextController;
  final Function onSubmit;

  CommentForm({
    required this.formKey,
    required this.commentTextController,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: commentTextController,
            decoration: InputDecoration(
              hintText: 'Leave a comment...',
              filled: true,
              fillColor: Colors.grey[800], // Dark background color
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none, // No visible border
              ),
              contentPadding: const EdgeInsets.all(16.0),
              hintStyle:
                  TextStyle(color: Colors.grey[400]), // Light hint text color
            ),
            style: const TextStyle(color: Colors.white), // Text color
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blue, // Button background color
              onPrimary: Colors.white, // Button text color
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                onSubmit();
              }
            },
            child: const Text(
              'Add comment',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}
