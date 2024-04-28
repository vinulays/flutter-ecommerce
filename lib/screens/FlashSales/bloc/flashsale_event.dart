part of 'flashsale_bloc.dart';

sealed class FlashsaleEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchFlashSaleEvent extends FlashsaleEvent {}

class AddFlashSaleEvent extends FlashsaleEvent {
  final FlashSale flashSale;

  AddFlashSaleEvent(this.flashSale);
}
