import 'package:flutter_ecommerce/models/cart.dart';
import 'package:flutter_ecommerce/models/cart_item.dart';
import 'package:flutter_ecommerce/services/cart_service.dart';

class CartRepository {
  final CartService cartService;

  CartRepository({required this.cartService});

  // * Add an item to the cart
  void addItemToCart(CartItem item) {
    cartService.addItemToCart(item);
  }

  // * Remove an item from the cart
  void removeItemFromCart(String itemName) {
    cartService.removeItemFromCart(itemName);
  }

  // * Add item quantity in the cart
  void addItemQuantity(String itemName) {
    cartService.addItemQuantity(itemName);
  }

  // * Remove item quantity in the cart
  void removeItemQuantity(String itemName) {
    cartService.removeItemQuantity(itemName);
  }

  // * Update the quantity of an item in the cart
  void updateItemQuantity(String itemId, int quantity) {
    cartService.updateItemQuantityInCart(itemId, quantity);
  }

  // * Get all items in the cart
  Cart getCart() {
    return cartService.getCart();
  }

  // * Clear all items from the cart
  void clearCart() {
    cartService.clearCart();
  }
}
