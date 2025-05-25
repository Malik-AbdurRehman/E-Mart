import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseServices {
  // Firebase Auth instance
  final auth = FirebaseAuth.instance;
  
  // Firestore instance
  final firestore = FirebaseFirestore.instance;
  
  // Firebase Storage instance
  final storage = FirebaseStorage.instance;

  // Get current user
  User? get currentUser => auth.currentUser;

  // Sign up method
  Future<UserCredential?> signUp({required String email, required String password}) async {
    try {
      return await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('Error during sign up: $e');
      return null;
    }
  }

  // Sign in method
  Future<UserCredential?> signIn({required String email, required String password}) async {
    try {
      return await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('Error during sign in: $e');
      return null;
    }
  }

  // Sign out method
  Future<void> signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print('Error during sign out: $e');
    }
  }

  // Store user data in Firestore
  Future<void> storeUserData({
    required String userId,
    required String name,
    required String email,
  }) async {
    try {
      await firestore.collection('users').doc(userId).set({
        'name': name,
        'email': email,
        'createdAt': Timestamp.now(),
      });
    } catch (e) {
      print('Error storing user data: $e');
    }
  }
} 