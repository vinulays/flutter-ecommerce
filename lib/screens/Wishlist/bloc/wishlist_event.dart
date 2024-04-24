part of 'wishlist_bloc.dart';

sealed class WishlistEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchWishListEvent extends WishlistEvent {}
