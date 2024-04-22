part of 'category_details_bloc.dart';

sealed class CategoryDetailsState extends Equatable {
  @override
  List<Object> get props => [];
}

final class CategoryDetailsInitial extends CategoryDetailsState {}

class CategoryLoading extends CategoryDetailsState {}

class CategoryLoaded extends CategoryDetailsState {
  final List<Product> products;

  CategoryLoaded(this.products);
  @override
  List<Object> get props => [products];
}

class CategoryLoadingError extends CategoryDetailsState {
  final String errorMessage;

  CategoryLoadingError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
