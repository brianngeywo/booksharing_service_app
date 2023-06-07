import 'package:booksharing_service_app/client/dashboard.dart';
import 'package:booksharing_service_app/client/login.dart';
import 'package:booksharing_service_app/client/signup.dart';
import 'package:booksharing_service_app/constants.dart';
import 'package:booksharing_service_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          foregroundColor: Colors.white,
          backgroundColor: textColor,
        ),
      ),
      home: LoginScreen(),
    );
  }
}
