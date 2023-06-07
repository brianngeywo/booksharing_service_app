import 'dart:io';
import 'dart:math';

import 'package:booksharing_service_app/models/book.dart';
import 'package:booksharing_service_app/models/user_model.dart';
import 'package:booksharing_service_app/services/book_service.dart';
import 'package:booksharing_service_app/constants.dart';
import 'package:booksharing_service_app/models/genre.dart';
import 'package:booksharing_service_app/services/firebase_storage_service.dart';
import 'package:booksharing_service_app/static_datas.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:file_picker/file_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class UploadBookPage extends StatefulWidget {
  const UploadBookPage({Key? key}) : super(key: key);

  @override
  _UploadBookPageState createState() => _UploadBookPageState();
}

class _UploadBookPageState extends State<UploadBookPage> {
  final _formKey = GlobalKey<FormState>();

  late String _title;
  late String _author;
  late Genre _genre;
  late String _abstract;
  late String? _fileUrl;
  late String _coverImageUrl;

  @override
  void initState() {
    super.initState();
    _genre = test_genres[0];
    _title = "";
    _author = "";
    _abstract = "";
    _fileUrl = null;
    _coverImageUrl = "";
  }

  Future<void> _pickBookFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'epub'], // Add more extensions if needed
    );

    if (result != null) {
      setState(() {
        _fileUrl = result.files.single.path;
      });
    }
  }

  Future<void> _pickCoverImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);

      try {
        final imageUrl = await FirebaseStorageService.uploadFile(file);
        setState(() {
          _coverImageUrl = imageUrl;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to upload book cover"),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  Future<void> _uploadBook() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Generate a random ID for the book
      String bookId = const Uuid().v4();

      // Create a new Book object
      Book book = Book(
        id: bookId,
        title: _title,
        author: _author,
        genre: _genre,
        postedBy: test_user,
        ratings: [],
        description: _abstract,
        coverUrl: _coverImageUrl,
        allowedUsers: [],
        fileUrl: _fileUrl,
      );

      // Upload the book file to Firebase Storage
      if (_fileUrl != null) {
        File file = File(_fileUrl!);
        try {
          String fileUrl = await FirebaseStorageService.uploadFile(file);
          book.fileUrl = fileUrl;
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Failed to upload book file"),
              duration: Duration(seconds: 3),
            ),
          );
        }
      }

      // Add the book to Firestore
      BookService().addBook(book);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Book uploaded successfully!"),
          duration: Duration(seconds: 3),
        ),
      );
      // Navigate back to the previous screen
      Navigator.pop(context);
    }
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
                  minLines: 15,
                  maxLines: null,
                  decoration: const InputDecoration(
                    labelText: 'Abstract',
                    alignLabelWithHint: true,
                  ),
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
                  onPressed: _pickCoverImage,
                  child: const Text(
                    'Upload Book Cover',
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                if (_coverImageUrl != null && _coverImageUrl.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Image.network(
                      _coverImageUrl!,
                      height: 200,
                    ),
                  ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _pickBookFile,
                  child: const Text(
                    'Attach Book File',
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                if (_fileUrl != null && _fileUrl!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Attached File: $_fileUrl',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(textColor),
                  ),
                  onPressed: _uploadBook,
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
