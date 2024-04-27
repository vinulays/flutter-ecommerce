part of 'orders_bloc.dart';

sealed class OrdersState extends Equatable {
  @override
  List<Object> get props => [];
}

final class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersLoaded extends OrdersState {
  final List<OrderLocal> orders;

  OrdersLoaded(this.orders);

  @override
  List<Object> get props => [orders];
}

class OrdersLoadingError extends OrdersState {
  final String errorMessage;

  OrdersLoadingError(this.errorMessage);
}

class OrderAdding extends OrdersState {}

class OrderAdded extends OrdersState {}

class OrderAddingError extends OrdersState {
  final String errorMessage;

  OrderAddingError(this.errorMessage);
}
