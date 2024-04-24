import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/services/wishlist_service.dart';

class WishListRepository {
  final WishListService _wishListService;

  WishListRepository({required WishListService wishListService})
      : _wishListService = wishListService;

  Future<List<Product>> getWishListProducts(String userId) async {
    return _wishListService.getLikedProducts(userId);
  }
}
