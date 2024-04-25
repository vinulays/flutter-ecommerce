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
        emit(ProductsLoadingError("Failed to fetch products: $e"));
      }
    });

    on<AddProductEvent>((event, emit) async {
      emit(ProductAdding());
      try {
        await _productRepository.addProduct(event.formData);
        emit(ProductAdded());

        add(FetchProductsEvent());
      } catch (e) {
        emit(ProductAddingError("Failed to add a product: $e"));
      }
    });
  }
}
