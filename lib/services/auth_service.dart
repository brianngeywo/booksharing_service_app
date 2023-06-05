import 'package:booksharing_service_app/models/book.dart';
import 'package:booksharing_service_app/models/comment.dart';
import 'package:booksharing_service_app/models/rating.dart';
import 'package:booksharing_service_app/test_datas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uuid/uuid.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Register a new user with email and password
  Future<String?> registerUser(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user?.uid;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Login with email and password
  Future<String?> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user?.uid;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign in with Google
  Future<String?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      // Obtain the Google Sign-In ID token and access token
      final String? idToken = googleAuth.idToken;
      final String? accessToken = googleAuth.accessToken;

      if (idToken != null && accessToken != null) {
        // Create a credential using the obtained ID token and access token
        final OAuthCredential credential = GoogleAuthProvider.credential(
          idToken: idToken,
          accessToken: accessToken,
        );

        // Sign in with the credential
        final UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(credential);
        return userCredential.user?.uid;
      } else {
        // Handle case where either ID token or access token is null
        throw Exception(
            'Failed to obtain Google Sign-In ID token or access token.');
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

  // Get the currently logged-in user
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  // Check if a user is currently logged in
  bool isLoggedIn() {
    final User? currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }
}
