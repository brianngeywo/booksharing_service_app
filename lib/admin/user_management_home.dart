import 'package:booksharing_service_app/admin/user_list_page.dart';
import 'package:booksharing_service_app/constants.dart';
import 'package:flutter/material.dart';

class UserManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      children: [
        _buildGridItem(
          Icon(
            Icons.list,
            color: textColor,
          ),
          Text('User List',
              style: TextStyle(
                color: textColor,
              )),
          () {
            // Navigate to User List page
            // Implement navigation logic here
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => UserListPage()));
          },
        ),
        _buildGridItem(
          const Icon(Icons.search),
          const Text('User Search'),
          () {
            // Navigate to User Search page
            // Implement navigation logic here
          },
        ),
        _buildGridItem(
          const Icon(Icons.security),
          const Text('User Roles and Permissions'),
          () {
            // Navigate to User Roles and Permissions page
            // Implement navigation logic here
          },
        ),
        _buildGridItem(
          const Icon(Icons.toggle_on),
          const Text('User Activation/Deactivation'),
          () {
            // Navigate to User Activation/Deactivation page
            // Implement navigation logic here
          },
        ),
        _buildGridItem(
          const Icon(Icons.edit),
          const Text('User Profile Editing'),
          () {
            // Navigate to User Profile Editing page
            // Implement navigation logic here
          },
        ),
        _buildGridItem(
          const Icon(Icons.analytics),
          const Text('User Statistics and Analytics'),
          () {
            // Navigate to User Statistics and Analytics page
            // Implement navigation logic here
          },
        ),
      ],
    );
  }

  Widget _buildGridItem(Widget leading, Widget title, VoidCallback onTap) {
    return Card(
      elevation: 10,
      color: const Color(0xFF400080),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(16),
      child: InkWell(
        onTap: onTap,
        child: GridTile(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              leading,
              const SizedBox(height: 10),
              title,
            ],
          ),
        ),
      ),
    );
  }
}
