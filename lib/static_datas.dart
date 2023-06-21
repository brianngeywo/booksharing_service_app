import 'dart:math';

import 'package:booksharing_service_app/client/all_books_page.dart';
import 'package:booksharing_service_app/client/borrow_book.dart';
import 'package:booksharing_service_app/client/discussion_group_dashboard_genres.dart';
import 'package:booksharing_service_app/client/forum_homepage.dart';
import 'package:booksharing_service_app/client/my_books_page.dart';
import 'package:booksharing_service_app/client/profile_page.dart';
import 'package:booksharing_service_app/client/recommended_books.dart';
import 'package:booksharing_service_app/client/upload_book.dart';
import 'package:booksharing_service_app/models/Navigation_item.dart';
import 'package:booksharing_service_app/models/book.dart';
import 'package:booksharing_service_app/models/genre.dart';
import 'package:booksharing_service_app/services/book_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

DateFormat formatter = DateFormat('yMMMd');
Random random = Random();

String getRandomId() {
  // Generate a random 6-character alphanumeric ID
  const String chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  Random random = Random();
  String id = '';
  for (int i = 0; i < 6; i++) {
    id += chars[random.nextInt(chars.length)];
  }
  return id;
}

// Create a list of genres in your app's state
List<Genre> genres = [
  Genre(
    id: "1",
    name: "Science Fiction",
    image_url:
        'https://images.unsplash.com/photo-1579566346927-c68383817a25?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
  ),
  Genre(
    id: "2",
    name: "Romance",
    image_url:
        'https://images.unsplash.com/photo-1521033719794-41049d18b8d4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8Um9tYW5jZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
  ),
  Genre(
    id: "3",
    name: "Mystery",
    image_url:
        'https://images.unsplash.com/photo-1611673982501-93cabee16c77?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTN8fEZpY3Rpb258ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
  ),
  Genre(
    id: "4",
    name: "Fantasy",
    image_url:
        'https://images.unsplash.com/photo-1560942485-b2a11cc13456?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=436&q=80',
  ),
  Genre(
    id: "5",
    name: "Fiction",
    image_url:
        'https://images.unsplash.com/photo-1624027492684-327af1fb7559?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzR8fEZpY3Rpb258ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
  ),
  Genre(
    id: "6",
    name: "Horror",
    image_url:
        'https://images.unsplash.com/photo-1601513445506-2ab0d4fb4229?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8SG9ycm9yfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
  ),
  Genre(
    id: "7",
    name: "Biography",
    image_url:
        'https://images.unsplash.com/photo-1601921004897-b7d582836990?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8bWFoYXRtYSUyMGdhbmRoaXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
  ),
  Genre(
    id: "8",
    name: "Classic",
    image_url:
        'https://images.unsplash.com/photo-1580974582391-a6649c82a85f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dmludGFnZSUyMGRyZXNzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
  ),
];

List<NavigationItem> navigationItems = [
  NavigationItem(
    icon: Icons.person,
    title: 'My Profile',
    imageUrl:
        'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80',
    navigate: (context) => Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProfilePage())),
  ),
  NavigationItem(
    icon: Icons.shopping_cart,
    title: 'Borrow Book',
    imageUrl:
        'https://images.unsplash.com/photo-1491841573634-28140fc7ced7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80',
    navigate: (context) async {
      List<Book>? books = await BookService().getBooks();
      if (books != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BorrowingPage(books: books),
          ),
        );
      }
    },
  ),
  NavigationItem(
    icon: Icons.cloud,
    title: 'Upload Book',
    imageUrl:
        'https://images.unsplash.com/photo-1629904888780-8de0c7aeed28?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80',
    navigate: (context) => Navigator.push(
        context, MaterialPageRoute(builder: (context) => UploadBookPage())),
  ),
  NavigationItem(
    icon: Icons.library_books,
    title: 'My Books',
    imageUrl:
        'https://images.unsplash.com/photo-1521587760476-6c12a4b040da?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80',
    navigate: (context) => Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyBooksPage())),
  ),
  NavigationItem(
    icon: Icons.library_books,
    title: 'All Books',
    imageUrl:
        'https://images.unsplash.com/photo-1550399105-c4db5fb85c18?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=871&q=80',
    navigate: (context) => Navigator.push(
        context, MaterialPageRoute(builder: (context) => AllBooksPage())),
  ),
  NavigationItem(
    icon: Icons.thumb_up_alt_rounded,
    title: 'Recommended',
    imageUrl:
        'https://images.unsplash.com/photo-1608659597669-b45511779f93?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1287&q=80',
    navigate: (context) => Navigator.push(
        context, MaterialPageRoute(builder: (context) => RecommendedBooks())),
  ),
  NavigationItem(
    icon: Icons.mark_chat_read,
    title: 'Forums',
    imageUrl:
        'https://images.unsplash.com/photo-1501386761578-eac5c94b800a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80',
    navigate: (context) => Navigator.push(
        context, MaterialPageRoute(builder: (context) => ForumHomePage())),
  ),
  NavigationItem(
    icon: Icons.people_alt,
    title: 'Discussion Groups',
    imageUrl:
        'https://images.unsplash.com/photo-1460518451285-97b6aa326961?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
    navigate: (context) => Navigator.push(context,
        MaterialPageRoute(builder: (context) => DiscussionGroupDashboard())),
  ),
];
