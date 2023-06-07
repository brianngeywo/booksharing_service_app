import 'package:booksharing_service_app/models/user_model.dart';
import 'package:booksharing_service_app/static_datas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uuid/uuid.dart';

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
    try {
      // Create a new user in Firebase Authentication
      var userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      String userId = userCredential.user!.uid;

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
    }
  }

  Future<String?> loginUser(String email, String password) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.size > 0) {
        final user = querySnapshot.docs[0];
        // Check if password matches or implement your desired authentication logic here
        // For demonstration purposes, we assume the password matches
        final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        return userCredential.user?.uid;
      } else {
        return null; // User not found
      }
    } catch (e) {
      print(e.toString());
      return null;
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
