import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecommerce/models/product.dart';

class WishListService {
  final FirebaseFirestore _firestore;

  WishListService({required FirebaseFirestore fireStore})
      : _firestore = fireStore;

  Future<List<Product>> getLikedProducts(String userId) async {
    try {
      final snapshot = await _firestore.collection('users').doc(userId).get();

      final data = snapshot.data() as Map<String, dynamic>;
      final likedProductIds = List<String>.from(data['likedProducts'] ?? []);

      final List<Future<DocumentSnapshot>> productFutures =
          likedProductIds.map((productId) {
        return _firestore.collection('products').doc(productId).get();
      }).toList();

      final List<DocumentSnapshot> productSnapshots =
          await Future.wait(productFutures);

      List<Product> likedProducts = [];

      for (var doc in productSnapshots) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

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
          sizes: List<String>.from(data["sizes"]),
          colors: List<String>.from(data["colors"]),
        );

        likedProducts.add(product);
      }

      return likedProducts;
    } catch (e) {
      throw ('Error fetching liked products: $e');
    }
  }
}
