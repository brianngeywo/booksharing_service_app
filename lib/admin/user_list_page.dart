import 'package:booksharing_service_app/test_datas.dart';
import 'package:flutter/material.dart';
import 'package:booksharing_service_app/models/user_model.dart'; // Replace with your user model

class UserListPage extends StatelessWidget {
  UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: test_users.length,
        itemBuilder: (context, index) {
          UserModel user = test_users[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=580&q=80"), // Replace with user avatar image
            ),
            title: Text(user.name), // Replace with user name
            subtitle:
                Text(user.email), // Replace with user email or other details
            onTap: () {
              // Handle user tap event
              // Implement navigation or other logic here
            },
          );
        },
      ),
    );
  }
}
