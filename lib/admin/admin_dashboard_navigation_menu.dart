import 'package:booksharing_service_app/constants.dart';
import 'package:booksharing_service_app/models/Navigation_item.dart';
import 'package:flutter/material.dart';

class AdminDashboardNavigationMenu extends StatelessWidget {
  List<NavigationItem> menuItems;
  NavigationItem selectedItem;
  Function(NavigationItem) onSelectItem;

  AdminDashboardNavigationMenu({
    super.key,
    required this.menuItems,
    required this.selectedItem,
    required this.onSelectItem,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Colors.blueGrey,
      width: 250.0,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          NavigationItem item = menuItems[index];
          return ListTile(
            title: Text(item.title),
            leading: Icon(item.icon),
            onTap: () {
              onSelectItem(item);
            },
            selected: item == selectedItem,
            selectedColor: textColor,
          );
        },
      ),
    );
  }
}
