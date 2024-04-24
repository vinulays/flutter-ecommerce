import 'package:cloud_firestore/cloud_firestore.dart';

class UserLocal {
  String? id;
  String email;
  String avatarURL;
  String displayName;
  String username;
  String contactNo;
  String gender;
  DateTime dob;
  String address;
  List<String> likedProducts;
  String role;

  UserLocal(
      {this.id,
      required this.email,
      required this.avatarURL,
      required this.displayName,
      required this.username,
      required this.contactNo,
      required this.gender,
      required this.dob,
      required this.address,
      required this.likedProducts,
      required this.role});

  factory UserLocal.fromFirestore(DocumentSnapshot doc, String emailAddress) {
    final data = doc.data() as Map<String, dynamic>;

    return UserLocal(
        id: doc.id,
        email: emailAddress,
        avatarURL: data['avatarURL'],
        displayName: data['displayName'],
        username: data['username'],
        contactNo: data['contactNo'],
        gender: data['gender'],
        dob: data['dob'].toDate(),
        address: data['address'],
        likedProducts: List<String>.from(
          data['likedProducts'],
        ),
        role: data["role"]);
  }
}
