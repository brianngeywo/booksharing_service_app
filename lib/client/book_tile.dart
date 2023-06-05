import 'package:booksharing_service_app/models/book.dart';
import 'package:booksharing_service_app/models/user_model.dart';
import 'package:flutter/material.dart';

class BookTile extends StatelessWidget {
  Book book;
  UserModel owner;

  BookTile({
    Key? key,
    required this.book,
    required this.owner,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        'https://via.placeholder.com/150',
        width: 70,
        height: 100,
        fit: BoxFit.cover,
      ),
      title: Text(book.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(book.author),
          Text(book.genre.name),
          Text(book.postedBy.name),
        ],
      ),
      trailing: ElevatedButton(
        onPressed: () {
          // Handle borrowing the book
        },
        child: Text('Borrow'),
      ),
    );
  }
}
