import 'dart:math';

import 'package:booksharing_service_app/client/forum_question_view.dart';
import 'package:booksharing_service_app/client/spinning_widget.dart';
import 'package:booksharing_service_app/models/book.dart';
import 'package:booksharing_service_app/constants.dart';
import 'package:booksharing_service_app/models/question.dart';
import 'package:booksharing_service_app/services/auth_service.dart';
import 'package:booksharing_service_app/services/book_service.dart';
import 'package:booksharing_service_app/services/forum_service.dart';
import 'package:booksharing_service_app/static_datas.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ForumHomePage extends StatefulWidget {
  const ForumHomePage({super.key});

  @override
  _ForumHomePageState createState() => _ForumHomePageState();
}

class _ForumHomePageState extends State<ForumHomePage> {
  final _formKey = GlobalKey<FormState>();
  List<Question> questions = [];
  String? _questionTitle = "";
  String? _questionBody = "";
  Book? _attachedBook;
  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    try {
      questions = await ForumService().fetchForumQuestions();
      setState(() {});
    } catch (e) {
      print('Failed to fetch questions: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Forum HomePage',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
      ),
      body: ListView(children: [
        Card(
          elevation: 10,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Question Title'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title for your question';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _questionTitle = value!;
                    },
                  ),
                  TextFormField(
                    minLines: 1,
                    maxLines: null,
                    decoration:
                        const InputDecoration(labelText: 'Question Body'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your question';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _questionBody = value!;
                    },
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(textColor),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        // If an attached book was selected, prompt the user to select it
                        _attachedBook ??=
                            (await showBookSelectionDialog(context));

                        // Generate a random ID for the question
                        String questionId = const Uuid().v4();

                        // Create a new Question object
                        Question question = Question(
                          id: questionId,
                          title: _questionTitle!,
                          body: _questionBody!,
                          attachedBook: _attachedBook,
                          postedBy: await AuthService().getCurrentUser(),
                          forumComments: [],
                          timeUploaded: DateTime.now(),
                        );
                        ForumService().addForumQuestion(question);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.green,
                            content: Text(
                              "Question posted successfully!",
                              style: TextStyle(color: Colors.white),
                            ),
                            duration: Duration(seconds: 3),
                          ),
                        );
                        setState(() {
                          _questionTitle = "";
                          _questionBody = "";
                          _attachedBook = null;
                          _formKey.currentState!.reset();
                        });
                      }
                    },
                    child: const Text(
                      'Post Question',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        StreamBuilder<List<Question>>(
          stream: ForumService().fetchForumQuestions().asStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final questions = snapshot.data!;
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  Question question = questions[index];

                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ForumQuestionView(question: question),
                      ),
                    ),
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      margin: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20.0,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              question.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(
                                  Icons.person,
                                  size: 15,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  question.postedBy.name,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Icon(
                                  Icons.access_time,
                                  size: 15,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  formatter.format(question.timeUploaded),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              question.body,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return SpinningWidget();
            }
          },
        ),
      ]),
    );
  }
}

Future<Book?> showBookSelectionDialog(BuildContext context) async {
  // Fetch list of books from Firestore
  List<Book> books = await BookService().getBooks();

  return showDialog<Book>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Select a book'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: books
              .map((book) => ListTile(
                    title: Text(book.title),
                    onTap: () => Navigator.of(context).pop(book),
                  ))
              .toList(),
        ),
      ),
    ),
  );
}
