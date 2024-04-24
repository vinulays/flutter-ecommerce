part of 'wishlist_bloc.dart';

sealed class WishlistEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchWishListEvent extends WishlistEvent {}

class ToggleWishlistProduct extends WishlistEvent {
  final Product product;

  ToggleWishlistProduct(this.product);

  @override
  List<Object> get props => [product];
}
