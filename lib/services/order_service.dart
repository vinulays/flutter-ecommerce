import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_ecommerce/models/order.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class OrderService {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  OrderService(
      {required FirebaseFirestore firestore,
      required FirebaseAuth firebaseAuth})
      : _firestore = firestore,
        _auth = firebaseAuth;

  Future<List<OrderLocal>> getOrdersByUserId() async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        QuerySnapshot querySnapshot = await _firestore
            .collection('orders')
            .where('customerId', isEqualTo: user.uid)
            .get();

        List<OrderLocal> orders = [];
        for (var doc in querySnapshot.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          OrderLocal order = OrderLocal(
              id: doc.id,
              customerId: data["customerId"],
              address: data["address"],
              paymentMethod: data["paymentMethod"],
              productQuantityMap:
                  Map<String, int>.from(data["productQuantityMap"]),
              cost: double.parse(data["cost"].toString()),
              createdAt: data["createdAt"].toDate());

          orders.add(order);
        }

        return orders;
      }

      return [];
    } catch (e) {
      throw Exception("Failed to fetch orders: $e");
    }
  }

  Future<void> addOrder(OrderLocal order) async {
    try {
      await _firestore.collection("orders").add({
        "customerId": order.customerId,
        "address": order.address,
        "paymentMethod": order.paymentMethod,
        "productQuantityMap": order.productQuantityMap,
        "cost": order.cost,
        "createdAt": order.createdAt
      });
    } catch (e) {
      throw Exception("Failed to add order: $e");
    }
  }
}
