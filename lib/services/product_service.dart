import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_ecommerce/models/product.dart';

class ProductService {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  ProductService(
      {required FirebaseFirestore firestore, required FirebaseStorage storage})
      : _firestore = firestore,
        _storage = storage;

  Future<List<Product>> getProducts() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('challenges')
          .orderBy("createdAt", descending: true)
          .get(const GetOptions(source: Source.server));

      List<Product> products = [];

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data();

        Product product = Product(
            id: doc.id,
            title: data['title'],
            description: data['description'],
            price: double.parse(data["price"].toString()),
            rating: double.parse(data['rating']
                .toString()), // * converting firebase number format to double format
            categoryId: data["categoryId"],
            isInStock: data["isInStock"],
            imageURLs: List<String>.from(
              data["imageURLs"],
            ),
            createdAt: data["createdAt"].toDate());

        products.add(product);
      }

      return products;
    } catch (e) {
      throw Exception('Failed to fetch challenges: $e');
    }
  }
}
