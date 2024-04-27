part of 'orders_bloc.dart';

sealed class OrdersEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchOrdersEvent extends OrdersEvent {}

class AddOrderEvent extends OrdersEvent {
  final OrderLocal order;

  AddOrderEvent(this.order);
}
