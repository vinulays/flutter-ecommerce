part of 'reviews_bloc.dart';

sealed class ReviewsState extends Equatable {
  @override
  List<Object> get props => [];
}

final class ReviewsInitial extends ReviewsState {}

class ReviewsLoading extends ReviewsState {}

class ReviewsLoaded extends ReviewsState {
  final List<Review> reviews;

  ReviewsLoaded(this.reviews);

  @override
  List<Object> get props => [reviews];
}

class ReviewsLoadingError extends ReviewsState {
  final String errorMessage;

  ReviewsLoadingError(this.errorMessage);
}

class ReviewAdding extends ReviewsState {}

class ReviewsAdded extends ReviewsState {}

class ReviewAddingError extends ReviewsState {
  final String errorMessage;

  ReviewAddingError(this.errorMessage);
}
