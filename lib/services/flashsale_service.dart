import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecommerce/models/flash_sale.dart';
import 'package:jiffy/jiffy.dart';

class FlashSaleService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addFlashSaleToFirebase(FlashSale flashSale) async {
    try {
      await _firestore.collection("flash_sales").add({
        'endDateTime': flashSale.endDateTime,
        'productIds': [],
        'discountPercentage': flashSale.discountPercentage,
      });
    } catch (e) {
      throw Exception("Failed to add a flash sale: $e");
    }
  }

  Future<FlashSale?> getCurrentFlashSale() async {
    final currentTime = Jiffy.parse(DateTime.now().toString());

    QuerySnapshot querySnapshot = await _firestore
        .collection("flash_sales")
        .where('endDateTime', isGreaterThan: currentTime.dateTime)
        .get();

    if (querySnapshot.docs.isEmpty) {
      return null;
    }

    final flashSaleDoc = querySnapshot.docs.first;

    Map<String, dynamic> data =
        querySnapshot.docs.first.data() as Map<String, dynamic>;

    return FlashSale(
      id: flashSaleDoc.id,
      endDateTime: data["endDateTime"].toDate(),
      productIds: List<String>.from(data['productIds']),
      discountPercentage: double.parse(data["discountPercentage"].toString()),
    );
  }

  Future<void> addProductIdToFlashSale(
      String flashSaleId, String productId) async {
    try {
      await _firestore.collection("flash_sales").doc(flashSaleId).update({
        'productIds': FieldValue.arrayUnion([productId]),
      });
    } catch (e) {
      throw Exception("Failed to add product to flash sale: $e");
    }
  }

  Future<void> removeProductFromFlashSale(
      String flashSaleId, String productId) async {
    try {
      await FirebaseFirestore.instance
          .collection("flash_sales")
          .doc(flashSaleId)
          .update({
        'productIds': FieldValue.arrayRemove([productId]),
      });
    } catch (e) {
      throw Exception("Failed to remove product from flash sale: $e");
    }
  }
}
