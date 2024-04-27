class OrderLocal {
  String? id;
  String customerId;
  String address;
  String paymentMethod;
  Map<String, int> productQuantityMap;
  double cost;
  DateTime createdAt;

  OrderLocal(
      {this.id,
      required this.customerId,
      required this.address,
      required this.paymentMethod,
      required this.productQuantityMap,
      required this.cost,
      required this.createdAt});
}
