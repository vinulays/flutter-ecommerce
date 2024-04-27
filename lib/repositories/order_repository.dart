import 'package:flutter_ecommerce/models/order.dart';
import 'package:flutter_ecommerce/services/order_service.dart';

class OrderRepository {
  final OrderService _orderService;

  OrderRepository({required OrderService orderService})
      : _orderService = orderService;

  Future<List<OrderLocal>> getOrderByUserId() async {
    return _orderService.getOrdersByUserId();
  }

  Future<void> addOrder(OrderLocal order) async {
    await _orderService.addOrder(order);
  }
}
