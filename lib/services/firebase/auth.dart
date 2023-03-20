import 'package:firebase_auth/firebase_auth.dart';
import 'package:sitter_swipe/models/user_data.dart';
import 'package:sitter_swipe/services/firebase/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ThisUser _userFromFirebaseUser(User user) {
    return ThisUser(uid: user.uid);
  }

  // sign in with email/password
  Future signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e);
    }
  }

  // register with email/password
  Future registerWithEmailAndPassword(
      String email, String password, UserData data) async {
    // data should come from the information that was entered upon registration
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;

      // create a new document for the user with the uid with empty datya
      await SitterDatabase(uid: user.uid).updateUserData(data);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e);
    }
  }

  void verifyPhoneNumber(String number) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: (c) => print("completed"),
        verificationFailed: (c) => print("failed"),
        codeSent: (_, __) => print("sent"),
        codeAutoRetrievalTimeout: (c) => print("teimout"));
  }

  // auth state change stream
  Stream<ThisUser?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user!));
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
