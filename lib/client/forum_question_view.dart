import 'dart:io';
import 'dart:math';

import 'package:booksharing_service_app/client/forum_question_comment.dart';
import 'package:booksharing_service_app/models/book.dart';
import 'package:booksharing_service_app/constants.dart';
import 'package:booksharing_service_app/models/question.dart';
import 'package:booksharing_service_app/test_datas.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ForumQuestionView extends StatefulWidget {
  final Question question;

  ForumQuestionView({required this.question});

  @override
  _ForumQuestionViewState createState() => _ForumQuestionViewState();
}

class _ForumQuestionViewState extends State<ForumQuestionView> {
  final _commentFormKey = GlobalKey<FormState>();
  TextEditingController _commentTextController = TextEditingController();

  void addComment(String commentBody) {
    setState(() {
      ForumQuestionComment comment = ForumQuestionComment(
        id: forum_comments.length.toString(),
        comment: commentBody,
        postedBy: test_users[Random().nextInt(test_users.length)],
        upvotes: [],
        downvotes: [],
      );
      forum_comments.add(comment);
    });
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
                    id: 'c${forum_comments.length + 1}',
                    comment: _commentTextController.text,
                    postedBy: test_users[Random().nextInt(test_users.length)],
                    upvotes: [],
                    downvotes: [],
                  );

                  // Add the new comment to the list of forum_comments
                  setState(() {
                    forum_comments.add(comment);
                    _commentTextController.clear();
                  });
                }
              },
              onBookSelect: () {
                // Implement book selection logic here
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
            buildCommentsList(),
          ],
        ),
      ),
    );
  }

  buildCommentsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: forum_comments.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                forum_comments[index].comment,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    'Posted by ${forum_comments[index].postedBy.name}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.arrow_upward),
                    onPressed: () {
                      setState(() {
                        if (!forum_comments[index]
                            .upvotes
                            .contains(test_users[0])) {
                          forum_comments[index].upvotes.add(test_users[0]);
                          if (forum_comments[index]
                              .downvotes
                              .contains(test_users[0])) {
                            forum_comments[index]
                                .downvotes
                                .remove(test_users[0]);
                          }
                        }
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_downward),
                    onPressed: () {
                      setState(() {
                        if (!forum_comments[index]
                            .downvotes
                            .contains(test_users[0])) {
                          forum_comments[index].downvotes.add(test_users[0]);
                          if (forum_comments[index]
                              .upvotes
                              .contains(test_users[0])) {
                            forum_comments[index].upvotes.remove(test_users[0]);
                          }
                        }
                      });
                    },
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '${forum_comments[index].upvotes.length - forum_comments[index].downvotes.length} points',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              const Divider(),
            ],
          ),
        );
      },
    );
  }
}

class AttachedBookWidget extends StatelessWidget {
  Book book;

  AttachedBookWidget({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
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
              // Implement download book logic here
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
  final Function? onBookSelect;

  CommentForm({
    required this.formKey,
    required this.commentTextController,
    required this.onSubmit,
    this.onBookSelect,
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
            decoration: const InputDecoration(
              hintText: 'Leave a comment...',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(),
            onPressed: _handleBookSelect,
            child: const Text(
              'Select a Book',
              style: TextStyle(
                  // color: Colors.black54,
                  ),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: textColor),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                onSubmit();
              }
            },
            child: const Text(
              'Submit',
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BookSelectionButton extends StatelessWidget {
  final Function(File) onFileSelected;

  BookSelectionButton({required this.onFileSelected});

  Future<void> _selectFile(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      final file = File(result.files.single.path!);
      onFileSelected(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _selectFile(context),
      child: const Text('Select a Book'),
    );
  }
}

Future<void> _handleBookSelect() async {
  TextEditingController commentTextController = TextEditingController();
  // Open the file picker to select a book
  final pickedFile = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf', 'epub'],
  );

  // If a file was picked, update the comment form with the selected book's name
  if (pickedFile != null) {
    final fileName = pickedFile.names.first;
    commentTextController.text = 'Selected book: $fileName';
  }
}
