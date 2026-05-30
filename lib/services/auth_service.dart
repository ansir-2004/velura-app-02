import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel? get currentUser {
    final user = _auth.currentUser;
    if (user != null) {
      return UserModel(
        id: user.uid,
        name: user.displayName ?? 'Velura User',
        email: user.email ?? '',
      );
    }
    return null;
  }

  Future<UserModel?> signIn(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      if (user != null) {
        return UserModel(
          id: user.uid,
          name: user.displayName ?? 'Velura User',
          email: user.email ?? '',
        );
      }
    } catch (e) {
      print('Login error: $e');
      return null;
    }
    return null;
  }

  Future<UserModel?> register(String name, String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      if (user != null) {
        await user.updateDisplayName(name);
        return UserModel(
          id: user.uid,
          name: name,
          email: user.email ?? '',
        );
      }
    } catch (e) {
      print('Register error: $e');
      return null;
    }
    return null;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
