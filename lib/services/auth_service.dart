import "package:firebase_auth/firebase_auth.dart";

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<String?> signIn({
    required String email,
    required String pass,
}) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email.trim(),
          password: pass
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return _handleAuthException(e);
    }
  }

  Future<String?> signUp({
    required String email,
    required String pass,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: pass,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return _handleAuthException(e);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<String?> sendPasswordResetEmail({
    required String email,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      return null;
    } on FirebaseAuthException catch (e) {
      return _handleAuthException(e);
    }
  }

  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case "user-not-found":
      case "wrong-password":
      case "invalid-credential":
        return "Invalid email or password.";
      case "invalid-email":
        return "The email address is not valid.";
      case "email-already-in-use":
        return "The account already exists for that email.";
      case "weak-password":
        return "The password provided is too weak.";
      default:
        return "An unknown error occurred.";
    }
  }
}