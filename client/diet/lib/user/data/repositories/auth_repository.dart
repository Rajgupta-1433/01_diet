import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<UserModel?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return UserModel(uid: userCredential.user!.uid, email: userCredential.user!.email!);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<UserModel?> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return UserModel(uid: userCredential.user!.uid, email: userCredential.user!.email!);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
