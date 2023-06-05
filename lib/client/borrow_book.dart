import 'package:booksharing_service_app/models/book.dart';
import 'package:booksharing_service_app/client/book_reading_page.dart';
import 'package:booksharing_service_app/constants.dart';
import 'package:booksharing_service_app/test_datas.dart';
import 'package:flutter/material.dart';

class BorrowingPage extends StatefulWidget {
  List<Book> books;

  BorrowingPage({Key? key, required this.books}) : super(key: key);

  @override
  _BorrowingPageState createState() => _BorrowingPageState();
}

class _BorrowingPageState extends State<BorrowingPage> {
  Book? _selectedBook;
  List<Book> _filteredBooks = [];

  @override
  void initState() {
    _filteredBooks = List.from(test_books);
    super.initState();
  }

  void _onBookSelected(Book book) {
    setState(() {
      _selectedBook = book;
    });
  }

  void _requestBookAccess() {
    // Code to request book access
    // This function can be triggered by a button press
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search',
            style: TextStyle(
              color: textColor,
            )),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for a book',
                prefixIcon: Icon(
                  Icons.search,
                  color: textColor,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _filteredBooks = test_books
                      .where((book) =>
                          book.title
                              .toLowerCase()
                              .contains(value.toLowerCase()) ||
                          book.genre.name
                              .toLowerCase()
                              .contains(value.toLowerCase()) ||
                          book.author
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                      .toList();
                });
              },
            ),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _filteredBooks.length,
            itemBuilder: (context, index) {
              final book = _filteredBooks[index];
              return Container(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Image.network(book.coverUrl),
                  title: Text(book.title),
                  subtitle: Text(book.author),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BookReadingPage(book: book))),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
