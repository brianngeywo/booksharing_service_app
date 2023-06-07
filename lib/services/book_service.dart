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

  Future<List<Book>> getBooksByGenre(String genreId) async {
    QuerySnapshot querySnapshot =
        await _booksRef.where('genre.id', isEqualTo: genreId).get();
    List<Book> books = querySnapshot.docs
        .map((doc) => Book.fromMap(doc.data() as Map<String, dynamic>? ?? {}))
        .toList();
    return books;
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
