class FlashSale {
  String? id;
  DateTime endDateTime;
  List<String> productIds;
  double discountPercentage;

  FlashSale(
      {this.id,
      required this.endDateTime,
      required this.productIds,
      required this.discountPercentage});
}
