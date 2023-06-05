import 'package:booksharing_service_app/admin/admin_forum_questions_page.dart';
import 'package:booksharing_service_app/admin/admin_main_content_page.dart';
import 'package:booksharing_service_app/admin/user_management_home.dart';
import 'package:booksharing_service_app/constants.dart';
import 'package:booksharing_service_app/models/Navigation_item.dart';
import 'package:booksharing_service_app/test_datas.dart';
import 'package:flutter/material.dart';

import 'admin_dashboard_navigation_menu.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  NavigationItem? _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = menuItems.first;
  }

  void _selectItem(NavigationItem item) {
    setState(() {
      _selectedItem = item;
    });
  }

  Widget _buildSelectedPage() {
    if (_selectedItem == menuItems[0]) {
      return AdminMainContentPage(navigationItems: userManagementActions);
    } else if (_selectedItem == menuItems[1]) {
      return AdminMainContentPage(navigationItems: bookManagementActions);
    } else if (_selectedItem == menuItems[2]) {
      return AdminMainContentPage(navigationItems: adminBookClubsActions);
    } else if (_selectedItem == menuItems[3]) {
      return ForumQuestionsPage(list: test_questions);
    } else {
      return AdminMainContentPage(navigationItems: userManagementActions);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left Side Menu
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                child: Text(
                  "Admin Panel",
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: textColor),
                  textAlign: TextAlign.start,
                ),
              ),
              my_divider,
              AdminDashboardNavigationMenu(
                menuItems: menuItems,
                selectedItem: _selectedItem!,
                onSelectItem: _selectItem,
              ),
            ],
          ),

          // Content Area
          Expanded(
            child: _buildSelectedPage(),
          ),
        ],
      ),
    );
  }
}
