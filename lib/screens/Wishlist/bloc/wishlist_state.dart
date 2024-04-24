part of 'wishlist_bloc.dart';

sealed class WishlistState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistLoaded extends WishlistState {
  final List<Product> wishlistProducts;

  WishlistLoaded(this.wishlistProducts);

  @override
  List<Object?> get props => [wishlistProducts];
}

class WishlistLoadingError extends WishlistState {
  final String errorMessage;

  WishlistLoadingError(this.errorMessage);
}

// class WishlistAdding extends WishlistState {}

// class WishlistAdded extends WishlistState {}

// class WishlistAddingError extends WishlistState {
//   final String errorMessage;

//   WishlistAddingError(this.errorMessage);
// }

// class WishlistRemoving extends WishlistState {}

// class WishlistRemoved extends WishlistState {}

// class WishlistRemovingError extends WishlistState {
//   final String errorMessage;

//   WishlistRemovingError(this.errorMessage);
// }
