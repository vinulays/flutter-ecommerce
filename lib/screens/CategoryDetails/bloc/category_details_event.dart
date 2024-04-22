part of 'category_details_bloc.dart';

sealed class CategoryDetailsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchCategoryDetailsEvent extends CategoryDetailsEvent {
  final String categoryId;

  FetchCategoryDetailsEvent(this.categoryId);
}
