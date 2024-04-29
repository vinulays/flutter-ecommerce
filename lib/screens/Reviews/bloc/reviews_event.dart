part of 'reviews_bloc.dart';

sealed class ReviewsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchReviewsEvent extends ReviewsEvent {
  final String productId;

  FetchReviewsEvent(this.productId);
}

class AddReviewEvent extends ReviewsEvent {
  final Review review;

  AddReviewEvent(this.review);
}
