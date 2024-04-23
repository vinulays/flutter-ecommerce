class CartItem {
  final String? id;
  final String name;
  final double price;
  final String imageUrl;
  final String color;
  final String size;
  int quantity;

  CartItem({
    this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.quantity,
    required this.color,
    required this.size,
  });
}
