import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_core/firebase_core.dart";

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

  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case "user-not-found":
        return "N";
    }
  }
}