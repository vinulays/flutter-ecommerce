class User {
  String? id;
  String email;
  String avatarURL;
  String displayName;
  String username;
  String contactNo;
  String gender;
  String dob;
  String address;
  List<String> likedProducts;

  User(
      {this.id,
      required this.email,
      required this.avatarURL,
      required this.displayName,
      required this.username,
      required this.contactNo,
      required this.gender,
      required this.dob,
      required this.address,
      required this.likedProducts});
}
