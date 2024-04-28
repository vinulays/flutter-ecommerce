class Product {
  String? id;
  String title;
  String description;
  double price;
  bool isInStock;
  String thumbnailURL;
  List<String> imageURLs;
  String categoryId;
  DateTime createdAt;
  double rating;
  List<String> sizes;
  List<String> colors;
  double discountPercentage; // * 0.1, 0.2, 0.3
  DateTime discountEndDateTime;

  Product(
      {this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.isInStock,
      required this.thumbnailURL,
      required this.imageURLs,
      required this.categoryId,
      required this.createdAt,
      required this.rating,
      required this.sizes,
      required this.colors,
      required this.discountPercentage,
      required this.discountEndDateTime});
}
