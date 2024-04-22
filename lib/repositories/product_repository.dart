import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/services/product_service.dart';

class ProductRepository {
  final ProductService _productService;

  ProductRepository({required ProductService productService})
      : _productService = productService;

  Future<List<Product>> getProducts() async {
    return _productService.getProducts();
  }

  Future<Product> getProductById(String productId) async {
    return _productService.getProductById(productId);
  }
}
