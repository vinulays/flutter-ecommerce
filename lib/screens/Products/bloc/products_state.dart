part of 'products_bloc.dart';

sealed class ProductsState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<Product> products;

  ProductsLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

class ProductsLoadingError extends ProductsState {
  final String errorMessage;

  ProductsLoadingError(this.errorMessage);
}

class ProductAdding extends ProductsState {}

class ProductAdded extends ProductsState {}

class ProductAddingError extends ProductsState {
  final String errorMessage;

  ProductAddingError(this.errorMessage);
}

class ProductUpdating extends ProductsState {}

class ProducteUpdated extends ProductsState {}

class ProductUpdatingError extends ProductsState {
  final String errorMessage;

  ProductUpdatingError(this.errorMessage);
}

class ProductDeleting extends ProductsState {}

class ProductDeleted extends ProductsState {}

class ProductDeletingError extends ProductsState {
  final String errorMessage;

  ProductDeletingError(this.errorMessage);
}

class ProductsSearching extends ProductsState {
  @override
  List<Object?> get props => [];
}
