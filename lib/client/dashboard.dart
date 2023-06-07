import 'package:booksharing_service_app/client/borrow_book.dart';
import 'package:booksharing_service_app/constants.dart';
import 'package:booksharing_service_app/client/discussion_group_dashboard_genres.dart';
import 'package:booksharing_service_app/client/forum_homepage.dart';
import 'package:booksharing_service_app/client/my_books_page.dart';
import 'package:booksharing_service_app/client/notifications_screen.dart';
import 'package:booksharing_service_app/client/profile_page.dart';
import 'package:booksharing_service_app/client/recommended_books.dart';
import 'package:booksharing_service_app/models/book.dart';
import 'package:booksharing_service_app/services/book_service.dart';
import 'package:booksharing_service_app/static_datas.dart';
import 'package:booksharing_service_app/client/upload_book.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Book Sharing App',
          style: TextStyle(
            color: textColor,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          // GestureDetector(
          //   onTap: () => Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => const NotificationsScreen())),
          //   child: Padding(
          //     padding: const EdgeInsets.only(right: 15.0),
          //     child: Icon(
          //       Icons.notifications,
          //       color: textColor,
          //     ),
          //   ),
          // )
        ],
      ),
      body: ListView(
        children: [
          GridView.count(
            crossAxisCount: 2,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              // User profile section
              GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage())),
                child: Card(
                  margin: const EdgeInsets.all(8.0),
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.person),
                          const SizedBox(height: 8),
                          Text(
                            'My Profile',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              GestureDetector(
                onTap: () async {
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
                child: Card(
                  margin: const EdgeInsets.all(8.0),
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.shopping_cart),
                          const SizedBox(height: 8),
                          Text(
                            'Borrow Book',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UploadBookPage())),
                child: Card(
                  margin: const EdgeInsets.all(8.0),
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.cloud),
                          const SizedBox(height: 8),
                          Text(
                            'Upload Book',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyBooksPage())),
                child: Card(
                  margin: const EdgeInsets.all(8.0),
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.library_books),
                          const SizedBox(height: 8),
                          Text(
                            'My Books',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Recommended books section
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RecommendedBooks())),
                child: Card(
                  margin: const EdgeInsets.all(8.0),
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.thumb_up_alt_rounded),
                          const SizedBox(height: 8),
                          Text(
                            'Recommended',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const ForumHomePage(),
                  ),
                ),
                child: Card(
                  margin: const EdgeInsets.all(8.0),
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.mark_chat_read),
                          const SizedBox(height: 8),
                          Text(
                            'Forums',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const DiscussionGroupDashboard(),
                  ),
                ),
                child: Card(
                  margin: const EdgeInsets.all(8.0),
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.people_alt),
                          const SizedBox(height: 8),
                          Text(
                            'Discussion Groups',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
