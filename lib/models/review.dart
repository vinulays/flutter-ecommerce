class Review {
  String? id;
  String customerId;
  String productId;
  String description;
  double rating;
  DateTime createdAt;

  Review(
      {this.id,
      required this.customerId,
      required this.productId,
      required this.createdAt,
      required this.description,
      required this.rating});
}
