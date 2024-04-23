part of 'shopping_cart_bloc.dart';

sealed class ShoppingCartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchCartEvent extends ShoppingCartEvent {}

class ResetCartEvent extends ShoppingCartEvent {}

class AddItemEvent extends ShoppingCartEvent {
  final CartItem item;

  AddItemEvent(this.item);
}

class RemoveItemEvent extends ShoppingCartEvent {
  final String itemName;

  RemoveItemEvent(this.itemName);
}

class AddItemQuantityEvent extends ShoppingCartEvent {
  final String itemName;

  AddItemQuantityEvent(this.itemName);
}

class RemoveItemQuantityEvent extends ShoppingCartEvent {
  final String itemName;

  RemoveItemQuantityEvent(this.itemName);
}

class UpdateItemQuantityEvent extends ShoppingCartEvent {
  final String itemId;
  final int newQuantity;

  UpdateItemQuantityEvent(this.itemId, this.newQuantity);
}
