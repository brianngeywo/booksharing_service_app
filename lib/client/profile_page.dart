import 'package:booksharing_service_app/client/edit_account_page.dart';
import 'package:booksharing_service_app/models/book.dart';
import 'package:booksharing_service_app/client/change_password_page.dart';
import 'package:booksharing_service_app/constants.dart';
import 'package:booksharing_service_app/client/email_preference.dart';
import 'package:booksharing_service_app/models/user_model.dart';
import 'package:booksharing_service_app/test_datas.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  UserModel user;
  ProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Account',
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Profile picture/avatar and cover photo
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                height: 200,
              ),
              Positioned(
                top: 0,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  height: 180,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1504805572947-34fad45aed93?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1517849845537-4d257902454a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=435&q=80'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 0),

          // User's full name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              myCurrentUser.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Bio/description
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Flutter developer and book enthusiast',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Icon(Icons.phone, size: 20),
                SizedBox(width: 5),
                Text('+1 (555) 555-5555'),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Icon(Icons.location_on, size: 20),
                SizedBox(width: 5),
                Text('New York, USA'),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Location and contact information
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Icon(Icons.email, size: 20),
                  SizedBox(width: 5),
                  Text('jane.doe@gmail.com'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Social media links
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(Icons.facebook, size: 30),
                SizedBox(width: 10),
                Icon(Icons.twelve_mp, size: 30),
                SizedBox(width: 10),
                Icon(Icons.g_translate, size: 30),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Account settings
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Account settings',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    // Handle password change
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditAccountPage(
                                  user: user,
                                )));
                  },
                  child: const Text(
                    'Edit profile',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    // Handle password change
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PasswordChangePage()));
                  },
                  child: const Text(
                    'Change password',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    // Handle email preferences
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const EmailPreferencesPage()));
                  },
                  child: const Text(
                    'Email preferences',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          ActivityFeed(
            recentlyBorrowedBooks: test_books,
            recentlyUploadedBooks: test_books,
          ),
        ]),
      ),
    );
  }
}

class ActivityFeed extends StatelessWidget {
  List<Book> recentlyBorrowedBooks;
  List<Book> recentlyUploadedBooks;

  ActivityFeed({
    Key? key,
    required this.recentlyBorrowedBooks,
    required this.recentlyUploadedBooks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            'Activity Feed',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
        _buildRecentBorrowsList(),
        const Divider(),
        _buildRecentUploadsList(),
      ],
    );
  }

  Widget _buildRecentBorrowsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            'Recently Borrowed',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: recentlyBorrowedBooks.length,
          itemBuilder: (BuildContext context, int index) {
            Book book = recentlyBorrowedBooks[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                  book.coverUrl,
                ),
              ),
              title: Text(
                book.title,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: Text('Borrowed by ${book.author}'),
            );
          },
        ),
      ],
    );
  }

  Widget _buildRecentUploadsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            'Recently Uploaded',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: recentlyUploadedBooks.length,
          itemBuilder: (BuildContext context, int index) {
            Book book = recentlyUploadedBooks[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                  book.coverUrl,
                ),
              ),
              title: Text(
                book.title,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: Text('Uploaded by ${book.author}'),
            );
          },
        ),
      ],
    );
  }
}
