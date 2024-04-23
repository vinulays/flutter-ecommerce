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
  final String itemColor;
  final String itemSize;

  RemoveItemEvent(this.itemName, this.itemColor, this.itemSize);
}

class AddItemQuantityEvent extends ShoppingCartEvent {
  final String itemName;
  final String itemColor;
  final String itemSize;

  AddItemQuantityEvent(this.itemName, this.itemColor, this.itemSize);
}

class RemoveItemQuantityEvent extends ShoppingCartEvent {
  final String itemName;
  final String itemColor;
  final String itemSize;

  RemoveItemQuantityEvent(this.itemName, this.itemColor, this.itemSize);
}

class UpdateItemQuantityEvent extends ShoppingCartEvent {
  final String itemId;
  final int newQuantity;

  UpdateItemQuantityEvent(this.itemId, this.newQuantity);
}
