class Product {
  String? id;
  String title;
  String description;
  double price;
  bool isInStock;
  List<String> imageURLs;
  String categoryId;
  DateTime createdAt;
  double rating;

  Product(
      {this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.isInStock,
      required this.imageURLs,
      required this.categoryId,
      required this.createdAt,
      required this.rating});
}
