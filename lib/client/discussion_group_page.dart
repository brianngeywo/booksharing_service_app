import 'dart:math';

import 'package:booksharing_service_app/client/book_reading_page.dart';
import 'package:booksharing_service_app/client/discussion_post_details.dart';
import 'package:booksharing_service_app/client/spinning_widget.dart';
import 'package:booksharing_service_app/constants.dart';
import 'package:booksharing_service_app/models/book.dart';
import 'package:booksharing_service_app/models/discussion_post.dart';
import 'package:booksharing_service_app/models/genre.dart';
import 'package:booksharing_service_app/services/auth_service.dart';
import 'package:booksharing_service_app/services/book_service.dart';
import 'package:booksharing_service_app/services/discussion_group_service.dart';
import 'package:booksharing_service_app/static_datas.dart';
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
  List<DiscussionPost> discussionPosts = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.genre.name} Discussion Group',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
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
            const SizedBox(height: 10.0),
            _buildBookRecommendationsList(),
            const SizedBox(height: 8.0),
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
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  Widget _buildBookRecommendationsList() {
    return Container(
      height: 180.0,
      child: FutureBuilder<List<Book>>(
        future: BookService().getBooksByGenre(widget.genre.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Book> recommendedBooks = snapshot.data!;
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: recommendedBooks.length,
              itemBuilder: (context, index) {
                Book book = recommendedBooks[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookReadingPage(book: book),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            book.coverUrl,
                            height: 120.0,
                            width: 80.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          book.title,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          book.author,
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
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else {
            return Center(child: SpinningWidget());
          }
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
                    AuthService().getCurrentUser().then((user) {
                      DiscussionPost myPost = DiscussionPost(
                        id: const Uuid().v4(),
                        title: _title,
                        author: user, // Replace with the actual user name
                        content: _body,
                        date: DateTime.now(),
                        comments: [],
                        genre: widget.genre,
                      );
                      // TODO: Handle post creation.
                      DiscussionGroupService().addDiscussionPost(myPost);
                      setState(() {
                        _title = '';
                        _body = '';
                        _formKey.currentState?.reset();
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Post created successfully!'),
                        ),
                      );
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
    return StreamBuilder<Object>(
        stream: DiscussionGroupService()
            .fetchDiscussionPostsByGenre(widget.genre)
            .asStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            discussionPosts = snapshot.data as List<DiscussionPost>;
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: discussionPosts.length,
              itemBuilder: (BuildContext context, int index) {
                DiscussionPost post = discussionPosts[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: ListTile(
                    title: Text(post.title),
                    subtitle: Text(post.author.name),
                    trailing: Text(
                        '${post.date.month}/${post.date.day}/${post.date.year}'),
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
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else {
            return Center(child: SpinningWidget());
          }
        });
  }
}
