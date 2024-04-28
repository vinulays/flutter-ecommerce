import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/models/flash_sale.dart';
import 'package:flutter_ecommerce/repositories/flashsale_repository.dart';

part 'flashsale_event.dart';
part 'flashsale_state.dart';

class FlashsaleBloc extends Bloc<FlashsaleEvent, FlashsaleState> {
  final FlashSaleRepository _flashSaleRepository;

  FlashsaleBloc({required FlashSaleRepository flashSaleRepository})
      : _flashSaleRepository = flashSaleRepository,
        super(FlashsaleInitial()) {
    on<FetchFlashSaleEvent>((event, emit) async {
      emit(FlashSalesLoading());

      try {
        final flashSales = await _flashSaleRepository.getAllFlashSales();
        emit(FlashSalesLoaded(flashSales));
      } catch (e) {
        emit(FlashSalesLoadingError("Failed to fetch flash sales: $e"));
      }
    });

    on<AddFlashSaleEvent>((event, emit) async {
      emit(FlashSaleAdding());

      try {
        await _flashSaleRepository.addFlashSale(event.flashSale);

        add(FetchFlashSaleEvent());
      } catch (e) {
        emit(FlashSalesLoadingError("Failed to add flash sales: $e"));
      }
    });
  }
}
