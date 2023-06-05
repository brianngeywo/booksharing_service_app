import 'package:booksharing_service_app/constants.dart';
import 'package:flutter/material.dart';

class AdminMainContentPage extends StatelessWidget {
  final List<Map<String, dynamic>> navigationItems;

  const AdminMainContentPage({super.key, required this.navigationItems});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      children: navigationItems.map((item) {
        return _buildGridItem(
            icon: item["icon"],
            title: item['label'],
            onTap: () {
              item["onTap"];
            });
      }).toList(),
    );
  }

  Widget _buildGridItem(
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return Card(
      elevation: 10,
      color: purple,
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
              Icon(
                icon,
                color: textColor,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
