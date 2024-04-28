import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/models/order.dart';
import 'package:flutter_ecommerce/repositories/order_repository.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrderRepository _orderRepository;

  OrdersBloc({required OrderRepository repository})
      : _orderRepository = repository,
        super(OrdersInitial()) {
    on<FetchOrdersEvent>((event, emit) async {
      emit(OrdersLoading());

      try {
        final orders = await _orderRepository.getOrderByUserId();
        emit(OrdersLoaded(orders));
      } catch (e) {
        emit(OrdersLoadingError("Failed to fetch orders: $e"));
      }
    });

    on<FetchAllOrdersEvent>((event, emit) async {
      emit(OrdersLoading());

      try {
        final orders = await _orderRepository.getAllOrders();
        emit(OrdersLoaded(orders));
      } catch (e) {
        emit(OrdersLoadingError("Failed to fetch orders: $e"));
      }
    });

    on<AddOrderEvent>((event, emit) async {
      emit(OrderAdding());

      try {
        await _orderRepository.addOrder(event.order);
        emit(OrderAdded());

        add(FetchOrdersEvent());
      } catch (e) {
        emit(OrderAddingError("Failed to add order: $e"));
      }
    });
  }
}
