import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/repositories/product_repository.dart';

part 'product_details_event.dart';
part 'product_details_state.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  final ProductRepository _productRepository;

  ProductDetailsBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(ProductDetailsInitial()) {
    on<FetchProductDetailsEvent>((event, emit) async {
      emit(ProductLoading());

      try {
        final Product product =
            await _productRepository.getProductById(event.productId);
        emit(ProductLoaded(product));
      } catch (e) {
        emit(ProductLoadingError("Failed to fetch the product: $e"));
      }
    });
  }
}
