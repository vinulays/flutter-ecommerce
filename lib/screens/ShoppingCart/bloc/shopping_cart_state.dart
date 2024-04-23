part of 'shopping_cart_bloc.dart';

sealed class ShoppingCartState extends Equatable {
  @override
  List<Object> get props => [];
}

final class ShoppingCartInitial extends ShoppingCartState {}

class ShoppingCartLoadedState extends ShoppingCartState {
  final Cart cart;

  ShoppingCartLoadedState(this.cart);
  @override
  List<Object> get props => [cart];
}

class ShoppingCartErrorState extends ShoppingCartState {
  final String errorMessage;

  ShoppingCartErrorState(this.errorMessage);
}

class CartItemAdding extends ShoppingCartState {}

class CartItemAdded extends ShoppingCartState {}

class CartItemAddError extends ShoppingCartState {
  final String errorMessage;

  CartItemAddError(this.errorMessage);
}

class CartItemRemoving extends ShoppingCartState {}

class CartItemRemoved extends ShoppingCartState {}

class CartItemRemoveError extends ShoppingCartState {
  final String errorMessage;

  CartItemRemoveError(this.errorMessage);
}

class CartItemQuantityAdding extends ShoppingCartState {}

class CartItemQuantityAdded extends ShoppingCartState {}

class CartItemQuantityAddError extends ShoppingCartState {
  final String errorMessage;

  CartItemQuantityAddError(this.errorMessage);
}

class CartItemQuantityRemoving extends ShoppingCartState {}

class CartItemQuantityRemoved extends ShoppingCartState {}

class CartItemQuantityRemoveError extends ShoppingCartState {
  final String errorMessage;

  CartItemQuantityRemoveError(this.errorMessage);
}

class CartResetting extends ShoppingCartState {}
