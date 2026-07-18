import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '2724968521-4vrnii1edaq3nnqe1esbnhrjacc3udin.apps.googleusercontent.com',
  );
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Google Sign In
  Future<User?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // The user canceled the sign-in
        return null;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // Save user to Firestore if they don't exist
      if (userCredential.user != null) {
        await _saveUserToFirestore(userCredential.user!);
      }

      return userCredential.user;
    } catch (e) {
      print("Error in Google Sign In: $e");
      rethrow;
    }
  }

  // Email/Password Sign Up
  Future<User?> signUpWithEmailAndPassword(String email, String password, String name) async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // Update display name
        await userCredential.user!.updateDisplayName(name);
        // Reload user to ensure displayName is updated
        await userCredential.user!.reload();
        final updatedUser = _auth.currentUser!;
        
        await _saveUserToFirestore(updatedUser);
        return updatedUser;
      }
    } catch (e) {
      print("Error in Email Sign Up: $e");
      // Re-throw to handle it in the UI (e.g., showing a snackbar with the error)
      rethrow;
    }
    return null;
  }

  // Email/Password Sign In
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      return userCredential.user;
    } catch (e) {
      print("Error in Email Sign In: $e");
      rethrow;
    }
  }

  Future<void> _saveUserToFirestore(User user) async {
    final docRef = _firestore.collection('users').doc(user.uid);
    final doc = await docRef.get();
    
    if (!doc.exists) {
      await docRef.set({
        'uid': user.uid,
        'email': user.email,
        'displayName': user.displayName,
        'photoURL': user.photoURL,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  // Sign Out
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  // Check auth state
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
