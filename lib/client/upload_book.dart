import 'dart:math';

import 'package:booksharing_service_app/models/book.dart';
import 'package:booksharing_service_app/services/book_service.dart';
import 'package:booksharing_service_app/constants.dart';
import 'package:booksharing_service_app/models/genre.dart';
import 'package:booksharing_service_app/test_datas.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class UploadBookPage extends StatefulWidget {
  const UploadBookPage({super.key});

  @override
  _UploadBookPageState createState() => _UploadBookPageState();
}

class _UploadBookPageState extends State<UploadBookPage> {
  final _formKey = GlobalKey<FormState>();

  /*
 This code defines four private variables: _title, _author, _genre, and _abstract. Each variable is marked as 'late',
 which means its value can be set later but must be set before it is used. The data types of _title, _author, and
 _abstract are String, while the data type of _genre is a custom data type called Genre. Genre is likely defined elsewhere
 in the codebase.
*/
  late String? _title;
  late String? _author;
  late Genre? _genre;
  late String? _abstract;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _genre = test_genres[0];
    _title = "";
    _author = "";
    _abstract = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Upload a Book',
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _title = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Author'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an author';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _author = value!;
                  },
                ),
                DropdownButtonFormField<Genre>(
                  decoration: const InputDecoration(labelText: 'Genre'),
                  value: _genre,
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a genre';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _genre = value!;
                    });
                  },
                  items: test_genres.map((genre) {
                    return DropdownMenuItem<Genre>(
                      value: genre,
                      child: Text(genre.name),
                    );
                  }).toList(),
                ),
                TextFormField(
                  minLines: 1,
                  maxLines: null,
                  decoration: const InputDecoration(labelText: 'Abstract'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a book abstract';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _abstract = value!;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(textColor),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      // Generate a random ID for the book
                      String bookId = const Uuid().v4();

                      // Create a new Book object
                      Book book = Book(
                        id: bookId,
                        title: _title!,
                        author: _author!,
                        genre: _genre!,
                        postedBy:
                            test_users[Random().nextInt(test_users.length)],
                        ratings: [], description: _abstract!,
                        coverUrl:
                            'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1374&q=80',
                        allowedUsers:
                            test_allowed_users, // Replace with the actual user ID
                      );
                      BookService().addBook(book);

                      // Call the onBookUploaded function and pass in the new book object
                      setState(() {
                        test_books.add(book);
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Book uploaded successfully!"),
                          duration: Duration(seconds: 3),
                        ),
                      );
                      // Navigate back to the previous screen
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    'Upload Book',
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
