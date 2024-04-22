import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/repositories/product_repository.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductRepository _productRepository;

  ProductsBloc({required ProductRepository repository})
      : _productRepository = repository,
        super(ProductsInitial()) {
    // * getting products from firebase
    on<FetchProductsEvent>((event, emit) async {
      emit(ProductsLoading());

      try {
        final products = await _productRepository.getProducts();
        emit(ProductsLoaded(products));
      } catch (e) {
        emit(ProductsLoadingError("failed to fetch products: $e"));
      }
    });
  }
}
