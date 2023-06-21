import 'package:booksharing_service_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signUpUser(
    String name,
    String email,
    String password,
    String coverImageUrl,
    String profileImageUrl,
    String phoneNumber,
  ) async {
    var userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    var myUser = userCredential.user;
    if (myUser != null) {
      try {
        // Create a new user in Firebase Authentication
        String userId = myUser.uid;

        UserModel user = UserModel(
          id: userId,
          name: name,
          email: email,
          phoneNumber: phoneNumber,
          address: "",
          bio: "",
          profilePictureUrl: profileImageUrl,
          coverImageUrl: coverImageUrl,
          password: password,
        );

        // Create a new user document in Firestore
        await _firestore.collection('users').doc(userId).set(
              user.toMap(),
            );
      } catch (e) {
        // Handle sign-up error
        print('Sign-up error: $e');
        SnackBar(
          content: Text(
            e.toString(),
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.redAccent,
        );
      }
    }
  }

  Future<User?> loginUser(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (userCredential.user != null) {
      try {
        final querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: email)
            .limit(1)
            .get();
        if (querySnapshot.size > 0) {
          final user = querySnapshot.docs[0];
          final storedPassword = user.data()[
              'password']; // Assuming the password field is named 'password'
          // Check if stored password matches the entered password
          if (storedPassword == password) {
            var text = "Login successful";
            SnackBar(
                content: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Colors.lightGreen);
            return userCredential.user;
          } else {
            var text = "Password does not match";
            SnackBar(
                content: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Colors.red);
            _firebaseAuth.signOut();
            return null; // Password does not match
          }
        } else {
          var text = "Please register for a new account";
          SnackBar(
              content: Text(
                text,
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red);
          _firebaseAuth.signOut();
          return null; // User not found
        }
      } catch (e) {
        print(e.toString());
        SnackBar(
            content: Text(
              e.toString(),
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.redAccent);
        return null;
      }
    }
  }

  // Logout the currently signed-in user
  Future<void> logoutUser() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }

// Get the current user
  Future<UserModel> getCurrentUser() async {
    UserModel currentUser = UserModel(
      id: '',
      name: '',
      email: '',
      address: '',
      phoneNumber: '',
      bio: '',
      profilePictureUrl: '',
      coverImageUrl: '',
      password: '',
    );
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get();
      if (snapshot.exists) {
        UserModel user =
            UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
        currentUser = user;
      }
    }
    return currentUser;
  }

  // Check if a user is currently logged in
  bool isLoggedIn() {
    final User? currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }
}
