import 'package:flutter/material.dart';

class RecentlyBorrowedBooks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Recently Borrowed Books',
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 10.0),
        Expanded(
          child: ListView.builder(
            itemCount: 5, // Display the 5 most recent borrowed books
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: const Icon(Icons.book),
                title: const Text('Book Title'),
                subtitle: const Text('Author Name'),
                trailing: const Text('Return Date'),
                onTap: () {
                  // Navigate to the book details page
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
