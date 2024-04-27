class PromoCode {
  String? id;
  String codeName;
  double discount;
  List<String> usedUserIds;

  PromoCode(
      {this.id,
      required this.codeName,
      required this.discount,
      required this.usedUserIds});
}
