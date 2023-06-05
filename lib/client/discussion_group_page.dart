import 'dart:math';

import 'package:booksharing_service_app/client/book_reading_page.dart';
import 'package:booksharing_service_app/client/discussion_post_details.dart';
import 'package:booksharing_service_app/constants.dart';
import 'package:booksharing_service_app/models/discussion_post.dart';
import 'package:booksharing_service_app/models/genre.dart';
import 'package:booksharing_service_app/test_datas.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class DiscussionGroupPage extends StatefulWidget {
  Genre genre;

  DiscussionGroupPage({required this.genre});

  @override
  _DiscussionGroupPageState createState() => _DiscussionGroupPageState();
}

class _DiscussionGroupPageState extends State<DiscussionGroupPage> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _body;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.genre.name} Discussion Group',
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16.0),
            _buildCreatePostSection(),
            const SizedBox(height: 32.0),
            Text(
              "Recommended Readings",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 16.0),
            _buildBookRecommendationsList(),
            const SizedBox(height: 16.0),
            Text(
              "Latest Posts",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 16.0),
            _buildPostList(),
          ],
        ),
      ),
    );
  }

  Widget _buildBookRecommendationsList() {
    return Container(
      height: 200.0, // Set the height of the container
      child: ListView.builder(
        // physics: NeverScrollableScrollPhysics(),
        scrollDirection:
            Axis.horizontal, // Set the scroll direction to horizontal
        itemCount: test_books
            .length, // Replace this with the number of recommended books
        itemBuilder: (context, index) {
          // Replace these dummy data with the actual book data

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                // Navigate to the book details page
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            BookReadingPage(book: test_books[index])));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      test_books[index].coverUrl,
                      height: 120.0,
                      width: 80.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    test_books[index].title,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    test_books[index].author,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCreatePostSection() {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create Post',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                minLines: 1,
                decoration: const InputDecoration(
                  labelText: 'Body',
                ),
                maxLines: null,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the body';
                  }
                  return null;
                },
                onSaved: (value) {
                  _body = value!;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(textColor)),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    DiscussionPost my_post = DiscussionPost(
                      id: const Uuid().v4(),
                      title: _title,
                      author: test_users[Random().nextInt(test_users.length)],
                      content: _body,
                      date: DateTime.now(),
                      comments: [],
                    );
                    // TODO: Handle post creation.
                    setState(() {
                      test_discussion_posts.add(my_post);
                    });
                  }
                },
                child: const Text(
                  'Create',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPostList() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: test_discussion_posts.length,
      itemBuilder: (BuildContext context, int index) {
        DiscussionPost post = test_discussion_posts[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: ListTile(
            title: Text(post.title),
            subtitle: Text(post.author.name),
            trailing:
                Text('${post.date.month}/${post.date.day}/${post.date.year}'),
            onTap: () {
              // TODO: Navigate to post details page.
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PostDetailsPage(
                            post: post,
                          )));
            },
          ),
        );
      },
    );
  }
}
