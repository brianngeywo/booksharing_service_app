import 'package:booksharing_service_app/models/blog.dart';
import 'package:booksharing_service_app/constants.dart';
import 'package:flutter/material.dart';

class BlogPostViewPage extends StatelessWidget {
  Blog blog;

  BlogPostViewPage({required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          blog.title,
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              blog.title,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'By ${blog.author}',
              style: TextStyle(fontSize: 16.0, color: textColor),
            ),
            SizedBox(height: 16.0),
            Text(
              blog.content,
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
