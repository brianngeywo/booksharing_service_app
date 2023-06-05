import 'package:booksharing_service_app/admin/admin_dashboard.dart';
import 'package:flutter/material.dart';

class AdminHomepage extends StatelessWidget {
  const AdminHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(
          // primarySwatch: Colors.yellow,
          ),
      home: const AdminDashboard(),
    );
  }
}
