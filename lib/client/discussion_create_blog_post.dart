import 'package:booksharing_service_app/constants.dart';
import 'package:flutter/material.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({super.key});

  @override
  _NewPostPageState createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Post',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Enter title',
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _contentController,
                decoration: const InputDecoration(
                  hintText: 'Enter content',
                ),
                maxLines: null,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Save post to database and navigate back to discussion group page
                Navigator.pop(context);
              },
              child: const Text('Post'),
            ),
          ),
        ],
      ),
    );
  }
}
