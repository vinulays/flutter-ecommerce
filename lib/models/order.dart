class OrderLocal {
  String? id;
  String customerId;
  String address;
  String paymentMethod;
  List<String> productIds;
  double cost;

  OrderLocal(
      {this.id,
      required this.customerId,
      required this.address,
      required this.paymentMethod,
      required this.productIds,
      required this.cost});
}
