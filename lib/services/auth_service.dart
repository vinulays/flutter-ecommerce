import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_ecommerce/models/user.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthService(
      {required FirebaseAuth firebaseAuth,
      required FirebaseFirestore firestore})
      : _firebaseAuth = firebaseAuth,
        _firestore = firestore;

  Future<User?> getCurrentUser() async {
    final user = _firebaseAuth.currentUser;
    return user;
  }

  Future<UserLocal?> loginWithEmailPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final userData = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      final user =
          Future<UserLocal?>.value(UserLocal.fromFirestore(userData, email));
      return user;
    } catch (e) {
      throw Exception('failed to log: $e');
    }
  }

  Future<void> signUp(
      {required String email,
      required String password,
      required String displayName,
      required String username,
      required String mobileNumber,
      required String role}) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      await _firestore.collection("users").doc(userCredential.user!.uid).set({
        'displayName': displayName,
        'username': username,
        'contactNo': mobileNumber,
        "role": role,
        "likedProducts": [],
        "avatarURL": "",
        "address": "",
      });
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }

  Future<UserLocal?> signUpWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      final GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );

      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      final displayName = googleSignInAccount?.displayName;
      final avatarURL = googleSignInAccount?.photoUrl;

      final User? user = userCredential.user;

      final DocumentSnapshot doc =
          await _firestore.collection('users').doc(user?.uid).get();

      if (!doc.exists) {
        await _firestore.collection('users').doc(user?.uid).set({
          'displayName': displayName,
          'avatarURL': avatarURL,
          'username': displayName,
          'likedProducts': [],
          'role': "user",
        });
      }

      final DocumentSnapshot docFinal =
          await _firestore.collection('users').doc(user?.uid).get();

      return UserLocal.fromFirestore(docFinal, user!.email);
    } catch (e) {
      throw Exception("failed to sign in gogle: $e");
      // return null;
    }
  }

  Future<UserLocal?> signUpWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      if (loginResult.status == LoginStatus.success) {
        final AuthCredential credential =
            FacebookAuthProvider.credential(loginResult.accessToken!.token);

        final UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(credential);

        final User? user = userCredential.user;

        if (user != null) {
          final DocumentSnapshot doc =
              await _firestore.collection('users').doc(user.uid).get();

          if (!doc.exists) {
            await _firestore.collection('users').doc(user.uid).set({
              'displayName': user.displayName,
              "avatarURL": user.photoURL,
              "username": user.displayName!.split(' ')[0],
              "role": "user",
              "likedProducts": []
            });
          }

          final DocumentSnapshot docFinal =
              await _firestore.collection('users').doc(user.uid).get();

          return UserLocal.fromFirestore(docFinal, user.email);
        }
      }
    } catch (e) {
      throw Exception("Failed to login facebook: $e");
    }
    return null;
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception("Failed to logout: $e");
    }
  }
}
