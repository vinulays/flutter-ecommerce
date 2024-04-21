part of 'product_details_bloc.dart';

sealed class ProductDetailsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchProductDetailsEvent extends ProductDetailsEvent {
  final String productId;

  FetchProductDetailsEvent(this.productId);
}
