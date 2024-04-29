import 'package:flutter_ecommerce/models/review.dart';
import 'package:flutter_ecommerce/services/review_service.dart';

class ReviewRepository {
  final ReviewService _reviewService;

  ReviewRepository({required ReviewService reviewService})
      : _reviewService = reviewService;

  Future<List<Review>> getReviewsByProductId(String productId) async {
    return _reviewService.getReviewsByProductId(productId);
  }

  Future<void> addReview(Review review) async {
    await _reviewService.addReview(review);
  }
}
