import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  FirebaseAuthService._internal();
  static final FirebaseAuthService _instance = FirebaseAuthService._internal();
  static FirebaseAuthService get instance => _instance;
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static User? get currentUser => _firebaseAuth.currentUser;
  static String? get currentUserId => currentUser?.uid;
  static bool get isLoggedIn => currentUser != null;
  static Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
}
