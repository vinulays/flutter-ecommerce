part of 'product_details_bloc.dart';

sealed class ProductDetailsState extends Equatable {
  @override
  List<Object> get props => [];
}

final class ProductDetailsInitial extends ProductDetailsState {
  ProductDetailsInitial();
}

class ProductLoading extends ProductDetailsState {}

class ProductLoaded extends ProductDetailsState {
  final Product product;

  ProductLoaded(this.product);

  @override
  List<Object> get props => [product];
}

class ProductLoadingError extends ProductDetailsState {
  final String errorMessage;

  ProductLoadingError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
