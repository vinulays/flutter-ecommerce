import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/models/cart.dart';
import 'package:flutter_ecommerce/models/cart_item.dart';
import 'package:flutter_ecommerce/repositories/cart_repository.dart';

part 'shopping_cart_event.dart';
part 'shopping_cart_state.dart';

class ShoppingCartBloc extends Bloc<ShoppingCartEvent, ShoppingCartState> {
  final CartRepository _cartRepository;

  ShoppingCartBloc({required CartRepository cartRepository})
      : _cartRepository = cartRepository,
        super(ShoppingCartLoadedState(Cart(items: [], subTotal: 0, total: 0))) {
    on<AddItemEvent>((event, emit) {
      emit(CartItemAdding());

      try {
        _cartRepository.addItemToCart(event.item);
        emit(CartItemAdded());

        // * refreshing the cart
        emit(ShoppingCartLoadedState(_cartRepository.getCart()));
      } catch (e) {
        emit(CartItemAddError("Cart item add error: $e"));
      }
    });

    on<RemoveItemEvent>((event, emit) {
      emit(CartItemRemoving());

      try {
        _cartRepository.removeItemFromCart(
            event.itemName, event.itemColor, event.itemSize);
        emit(CartItemRemoved());

        emit(ShoppingCartLoadedState(_cartRepository.getCart()));
      } catch (e) {
        emit(CartItemRemoveError("Cart item remove error: $e"));
      }
    });

    on<AddItemQuantityEvent>((event, emit) {
      emit(CartItemQuantityAdding());
      try {
        _cartRepository.addItemQuantity(
            event.itemName, event.itemColor, event.itemSize);
        emit(CartItemQuantityAdded());

        emit(ShoppingCartLoadedState(_cartRepository.getCart()));
      } catch (e) {
        emit(CartItemQuantityAddError("Cart quantity add error: $e"));
      }
    });

    on<RemoveItemQuantityEvent>((event, emit) {
      emit(CartItemQuantityRemoving());
      try {
        _cartRepository.removeItemQuantity(
            event.itemName, event.itemColor, event.itemSize);
        emit(CartItemQuantityRemoved());

        emit(ShoppingCartLoadedState(_cartRepository.getCart()));
      } catch (e) {
        emit(CartItemQuantityRemoveError("Cart quantity remove error: $e"));
      }
    });

    on<UpdateItemQuantityEvent>((event, emit) {
      _cartRepository.updateItemQuantity(event.itemId, event.newQuantity);

      emit(ShoppingCartLoadedState(_cartRepository.getCart()));
    });

    on<ResetCartEvent>((event, emit) {
      emit(CartResetting());
      _cartRepository.clearCart();

      emit(ShoppingCartLoadedState(_cartRepository.getCart()));
    });
  }
}
