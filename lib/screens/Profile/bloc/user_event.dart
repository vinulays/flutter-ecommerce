part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchAddresses extends UserEvent {}

class AddAddress extends UserEvent {
  final String address;

  AddAddress(this.address);
}
