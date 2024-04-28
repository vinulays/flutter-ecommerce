part of 'flashsale_bloc.dart';

sealed class FlashsaleState extends Equatable {
  @override
  List<Object> get props => [];
}

final class FlashsaleInitial extends FlashsaleState {}

class FlashSalesLoading extends FlashsaleState {}

class FlashSalesLoaded extends FlashsaleState {
  final List<FlashSale> flashSales;

  FlashSalesLoaded(this.flashSales);

  @override
  List<Object> get props => [flashSales];
}

class FlashSalesLoadingError extends FlashsaleState {
  final String errorMessage;

  FlashSalesLoadingError(this.errorMessage);
}

class FlashSaleAdding extends FlashsaleState {}

class FlashSaleAdded extends FlashsaleState {}

class FlashSaleAddingError extends FlashsaleState {
  final String errorMessage;

  FlashSaleAddingError(this.errorMessage);
}
