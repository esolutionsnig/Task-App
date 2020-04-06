import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasks/models/user.dart';
import 'package:tasks/services/database.dart';
import 'package:tasks/shared/general.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create user object based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {

    // user: {uid: uw5rjKBPQ1dt5f39SxqK2wDRaG52, isAnonymous: false, providerData: [{uid: uw5rjKBPQ1dt5f39SxqK2wDRaG52, providerId: firebase, email: ibeh@yahoo.com}, {uid: ibeh@yahoo.com, providerId: password, email: ibeh@yahoo.com}], providerId: firebase, creationTimestamp: 1586034383728, lastSignInTimestamp: 1586073883516, email: ibeh@yahoo.com, isEmailVerified: false}}

    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // Sign in Anonymously
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Create a method to sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // Register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      // Create a new document for user profile with the uid
      await  DatabaseService(uid: user.uid).updateUserData("User", "New", 0, NEW_USER_ICON);

      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // Sign Out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

}
