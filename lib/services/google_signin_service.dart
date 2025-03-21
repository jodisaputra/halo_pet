import 'package:firebase_auth/firebase_auth.dart';

class GoogleSignInService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Direct Firebase approach
  Future<String?> getGoogleIdToken() async {
    try {
      // Create a Google Auth Provider
      final googleProvider = GoogleAuthProvider();

      // Add scopes if needed
      googleProvider.addScope('email');
      googleProvider.addScope('profile');

      // Sign in directly with Firebase
      final userCredential = await _auth.signInWithProvider(googleProvider);

      if (userCredential.user == null) {
        return null;
      }

      // Get the ID token
      final idToken = await userCredential.user?.getIdToken();

      print('Successfully signed in with Firebase: ${userCredential.user?.email}');

      return idToken;
    } catch (e) {
      print('Firebase direct sign-in error: $e');
      // Return null instead of rethrowing to maintain your current error handling
      return null;
    }
  }

  // Sign out from Firebase
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      print('Successfully signed out from Firebase');
    } catch (error) {
      print('Error signing out from Firebase: $error');
    }
  }
}