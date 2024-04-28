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
          discountPercentage:
              double.parse(data["discountPercentage"].toString()),
          rating: double.parse(data['rating']
              .toString()), // * converting firebase number format to double format
          categoryId: data["categoryId"],
          isInStock: data["isInStock"],
          thumbnailURL: data["thumbnailURL"],
          imageURLs: List<String>.from(
            data["imageURLs"],
          ),
          createdAt: data["createdAt"].toDate(),
          discountEndDateTime: data["discountEndDateTime"].toDate(),
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

  Future<void> toggleProductInWishlist(String userId, String productId) async {
    try {
      final DocumentReference userDocRef =
          _firestore.collection('users').doc(userId);

      final DocumentSnapshot userSnapshot = await userDocRef.get();
      List<String> likedProducts =
          List<String>.from(userSnapshot.get('likedProducts') ?? []);

      if (likedProducts.contains(productId)) {
        likedProducts.remove(productId);
      } else {
        likedProducts.add(productId);
      }

      await userDocRef.update({'likedProducts': likedProducts});
    } catch (e) {
      throw Exception('Failed to toggle product in wishlist: $e');
    }
  }
}
