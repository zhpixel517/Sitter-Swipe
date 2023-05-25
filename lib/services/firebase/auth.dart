import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sitter_swipe/models/user_data.dart';
import 'package:sitter_swipe/pages/register/register_viewmodel.dart';
import 'package:sitter_swipe/services/di.dart';
import 'package:sitter_swipe/services/firebase/database.dart';
import 'package:sitter_swipe/services/storage.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final RegisterViewModel _registerViewModel = instance<RegisterViewModel>();

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
  Future<bool> registerWithEmailAndPassword(
      String email, String password, UserData data) async {
    // data should come from the information that was entered upon registration
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User user = result.user!;
      data.uid = user.uid; // set the user id

      // this try block would most likely catch if the email is already registered or not

      // take the list of profileImages, upload them,
      // and then save their respective download urls
      // then put those download urls inside a user's data.

      final profileImages =
          await _getDownloadUrlsForImages(data, data.profileImages!);

      data.profileImageDownloadUrls = profileImages;

      // create a new document for the user with the uid and inputted data
      await updateUserData(user, data);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
//TODO: need a check to see if the email is already taken or not FIRST

  /// Returns a list of the download urls for each of the images uploaded
  Future<List<String>> _getDownloadUrlsForImages(
      UserData data, List<File> images) async {
    List<String> urls = [];
    for (File file in images) {
      String downloadUrl = await SitterDatabase(uid: data.uid)
          .uploadImageToFirebase(file, data.uid!);
      urls.add(downloadUrl);
    }
    return urls;
  }

  String _convertToProperlyFormattedPhoneNumber(String number) {
    RegExp phone = RegExp(r'(\d{3})(\d{3})(\d{4})');
    //TODO: phone number regex
    return number;
  }

  updateUserData(User user, UserData data) async {
    // NOT using DI for SitterDatabase
    // because uid could be different each time.

    await SitterDatabase(uid: user.uid).updateUserData(data);
    return _userFromFirebaseUser(user);
  }

  verifyPhoneNumber(String number) async {
    String formattedNumber = _convertToProperlyFormattedPhoneNumber(number);
    /*
    await _auth.verifyPhoneNumber(
        phoneNumber: "+1$number",
        verificationCompleted: (c) => print("completed"),
        verificationFailed: (c) => print(c),
        codeSent: (_, __) => print("sent"),
        codeAutoRetrievalTimeout: (c) => print("teimout"));
        */
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
