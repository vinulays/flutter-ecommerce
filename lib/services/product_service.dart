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
          .collection('products')
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
          thumbnailURL: data["thumbnailURL"],
          imageURLs: List<String>.from(
            data["imageURLs"],
          ),
          createdAt: data["createdAt"].toDate(),
        );

        products.add(product);
      }

      return products;
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }

  Future<Product> getProductById(String productId) async {
    try {
      DocumentSnapshot productDoc =
          await _firestore.collection('products').doc(productId).get();

      if (productDoc.exists) {
        Map<String, dynamic> data = productDoc.data() as Map<String, dynamic>;

        Product challenge = Product(
          id: productDoc.id,
          title: data['title'],
          description: data['description'],
          price: double.parse(data["price"].toString()),
          rating: double.parse(data['rating']
              .toString()), // * converting firebase number format to double format
          categoryId: data["categoryId"],
          isInStock: data["isInStock"],
          thumbnailURL: data["thumbnailURL"],
          imageURLs: List<String>.from(
            data["imageURLs"],
          ),
          createdAt: data["createdAt"].toDate(),
        );

        return challenge;
      } else {
        throw Exception('Challenge with id $productId not found');
      }
    } catch (e) {
      // Handle errors if any
      throw Exception('Failed to get product: $e');
    }
  }
}
