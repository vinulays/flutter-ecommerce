import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_ecommerce/models/user.dart';

class UserService {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  UserService(
      {required FirebaseFirestore firestore,
      required FirebaseAuth firebaseAuth})
      : _firestore = firestore,
        _auth = firebaseAuth;

  Future<List<String>> getUserAddresses() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();

        if (userDoc.exists) {
          List<dynamic> addressesData = userDoc['addresses'] ?? [];
          List<String> addresses = List<String>.from(addressesData);

          return addresses;
        }
      }

      return [];
    } catch (e) {
      throw Exception('Failed to fetch user addresses: $e');
    }
  }

  Future<void> addAddress(String address) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentReference userRef =
            _firestore.collection('users').doc(user.uid);

        await userRef.update({
          'addresses': FieldValue.arrayUnion([address])
        });
      }
    } catch (e) {
      throw Exception('Failed to add address: $e');
    }
  }

  Future<UserLocal> getUserDetails(String userId) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(userId).get();

      Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;

      UserLocal userDetails = UserLocal(
          id: snapshot.id,
          username: userData['username'],
          displayName: userData["displayName"],
          likedProducts: List<String>.from(userData["likedProducts"]),
          role: userData["role"],
          avatarURL: userData["avatarURL"]);

      return userDetails;
    } catch (e) {
      throw Exception("Failed to fetch user details: $e");
    }
  }
}
