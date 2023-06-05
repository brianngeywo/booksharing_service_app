import 'package:booksharing_service_app/models/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late CollectionReference _booksRef;

  BookService() {
    _booksRef = _db.collection('books');
  }

  Future<List<Book>> getBooks() async {
    QuerySnapshot querySnapshot = await _booksRef.get();
    return querySnapshot.docs
        .map((doc) => Book.fromMap(doc.data() as Map<String, dynamic>? ?? {}))
        .toList();
  }

  Future<Book> getBookById(String id) async {
    DocumentSnapshot doc = await _booksRef.doc(id).get();
    return Book.fromMap(doc.data() as Map<String, dynamic>? ?? {});
  }

  Future<void> addBook(Book book) async {
    await _booksRef.add(book.toMap());
  }

  Future<void> updateBook(Book book) async {
    await _booksRef.doc(book.id).update(book.toMap());
  }

  Future<void> deleteBook(String id) async {
    await _booksRef.doc(id).delete();
  }
}
/*

Here, we first import the required packages, including `cloud_firestore`, which provides the Firestore database service. We then define the `BookService` class and initialize it with a reference to the `books` collection in Firestore.

The `getBooks` method retrieves all books in the collection by calling `get` on `_booksRef`, which returns a `QuerySnapshot`. We then map each document in the snapshot to a `Book` object using the `fromMap` factory constructor and return a list of these objects.

The `getBookById` method retrieves a single book with the specified ID by calling `doc(id)` on `_booksRef`, which returns a `DocumentSnapshot`. We then create a `Book` object from the data in the snapshot using the `fromMap` factory constructor and return it.

The `addBook` method adds a new book to the collection by calling `add` on `_booksRef` with the book's data as a map.

The `updateBook` method updates an existing book in the collection by calling `update` on `_booksRef.doc(id)` with the updated book data as a map.

The `deleteBook` method deletes a book with the specified ID from the collection by calling `delete` on `_booksRef.doc(id)`.

 */
