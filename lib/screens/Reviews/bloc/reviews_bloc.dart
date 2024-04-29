import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/models/review.dart';
import 'package:flutter_ecommerce/repositories/review_repository.dart';

part 'reviews_event.dart';
part 'reviews_state.dart';

class ReviewsBloc extends Bloc<ReviewsEvent, ReviewsState> {
  final ReviewRepository _reviewRepository;
  ReviewsBloc({required ReviewRepository repository})
      : _reviewRepository = repository,
        super(ReviewsInitial()) {
    on<FetchReviewsEvent>((event, emit) async {
      emit(ReviewsLoading());
      try {
        final reviews =
            await _reviewRepository.getReviewsByProductId(event.productId);
        emit(ReviewsLoaded(reviews));
      } catch (e) {
        emit(ReviewsLoadingError("Failed to fetch reviews: $e"));
      }
    });
  }
}
