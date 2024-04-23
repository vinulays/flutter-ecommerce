import 'package:flutter_ecommerce/models/cart.dart';
import 'package:flutter_ecommerce/models/cart_item.dart';

class CartService {
  Cart cart = Cart(items: [], subTotal: 0, total: 0);

  // * Add an item to the cart
  void addItemToCart(CartItem item) {
    cart.addItem(item);
  }

  // * Remove an item from the cart
  void removeItemFromCart(String itemName, String color, String size) {
    cart.removeItem(itemName, color, size);
  }

  void addItemQuantity(String itemName, String color, String size) {
    cart.addItemQuantity(itemName, color, size);
  }

  void removeItemQuantity(String itemName, String color, String size) {
    cart.removeItemQuantity(itemName, color, size);
  }

  // * Update the quantity of an item in the cart
  void updateItemQuantityInCart(String itemId, int quantity) {
    cart.updateItemQuantity(itemId, quantity);
  }

  // * Get all items in the cart
  Cart getCart() {
    return cart;
  }

  // * Clear all items from the cart
  void clearCart() {
    cart.items = [];
    cart.subTotal = 0;
    cart.total = 0;
  }
}
