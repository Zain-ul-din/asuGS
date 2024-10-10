import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSigin = GoogleSignIn();

  User? get getUser => _auth.currentUser;
  Stream<User?> get user => _auth.userChanges();

  Future<String?> getUserName() async {
    User? user = _auth.currentUser;
    if (user != null) {
      return user.displayName;
    }
    return null;
  }

  Future<User?> googleSignIn() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSigin.signIn();
      GoogleSignInAuthentication? googleAuth =
          await googleSignInAccount?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken ?? "",
        idToken: googleAuth?.idToken ?? "",
      );

      UserCredential? result = await _auth.signInWithCredential(credential);

      print('loggedIn User: ');
      print(result.user);

      // TODO: send user credentials to our server
      // await _updateUserData(result.user);

      return result.user;
    } catch (err) {
      print(err);
      return null;
    }
  }

  // Future<void> _updateUserData(User? user) async {
  //   if (user == null) return;
  //   DocumentReference userRef = _db.collection('patients').doc(user.uid);

  //   // Get FCM token
  //   String? fcmToken = await getToken();

  //   return userRef.set({
  //     'uid': user.uid,
  //     'displayName': user.displayName ?? '',
  //     'email': user.email ?? '',
  //     'photoURL': user.photoURL ?? '',
  //     'lastSignInTime': user.metadata.lastSignInTime?.toIso8601String() ?? '',
  //     'creationTime': user.metadata.creationTime?.toIso8601String() ?? '',
  //     'fcm_token': fcmToken, // Store FCM token
  //   }, SetOptions(merge: true));
  // }

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signOut() async {
    try {
      // Sign out from Firebase authentication
      await _auth.signOut();
      // Sign out from Google if user was signed in with Google
      await _googleSignIn.signOut();
    } catch (err) {
      print(err);
    }
  }
}