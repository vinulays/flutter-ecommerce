part of 'products_bloc.dart';

sealed class ProductsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchProductsEvent extends ProductsEvent {}

class AddProductEvent extends ProductsEvent {
  final Map<String, dynamic> formData;

  AddProductEvent(this.formData);
}

class UpdateProductEvent extends ProductsEvent {
  final Map<String, dynamic> formData;

  UpdateProductEvent(this.formData);
}

class DeleteProductEvent extends ProductsEvent {
  final String productId;

  DeleteProductEvent(this.productId);
}

class ResetProductsEvent extends ProductsEvent {}
