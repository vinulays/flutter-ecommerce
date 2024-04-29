import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecommerce/models/review.dart';

class ReviewService {
  final FirebaseFirestore _firestore;

  ReviewService({required FirebaseFirestore firestore})
      : _firestore = firestore;

  Future<List<Review>> getReviewsByProductId(String productId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('reviews')
          .where('productId', isEqualTo: productId)
          .get();

      List<Review> reviews = [];
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Review review = Review(
          id: doc.id,
          customerId: data['customerId'],
          productId: data['productId'],
          description: data['description'],
          rating: double.parse(data['rating'].toString()),
          createdAt: data['createdAt'].toDate(),
        );
        reviews.add(review);
      }
      return reviews;
    } catch (e) {
      throw Exception("Failed to fetch reviews: $e");
    }
  }

  Future<void> addReview(Review review) async {
    try {
      await _firestore.collection('reviews').add({
        'customerId': review.customerId,
        'productId': review.productId,
        'description': review.description,
        'rating': review.rating,
        'createdAt': DateTime.now(),
      });

      List<Review> reviews = await getReviewsByProductId(review.productId);

      double overallRating = 0;
      int noOfRatings = reviews.length;

      for (var review in reviews) {
        overallRating += review.rating;
      }

      overallRating /= noOfRatings;

      await _firestore.collection('products').doc(review.productId).update({
        'rating': overallRating,
        'noOfReviews': noOfRatings,
      });
    } catch (e) {
      throw Exception("Failed to add review: $e");
    }
  }
}
