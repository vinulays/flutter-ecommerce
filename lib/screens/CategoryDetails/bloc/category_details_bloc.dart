import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/repositories/product_repository.dart';

part 'category_details_event.dart';
part 'category_details_state.dart';

class CategoryDetailsBloc
    extends Bloc<CategoryDetailsEvent, CategoryDetailsState> {
  final ProductRepository _productRepository;

  CategoryDetailsBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(CategoryDetailsInitial()) {
    on<FetchCategoryDetailsEvent>((event, emit) async {
      emit(CategoryLoading());

      try {
        final List<Product> products =
            await _productRepository.getProductsByCategoryId(event.categoryId);
        emit(CategoryLoaded(products));
      } catch (e) {
        emit(CategoryLoadingError("Failed to fetch category products: $e"));
      }
    });
  }
}
