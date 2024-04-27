part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

class AddressesLoading extends UserState {}

class AddressesLoaded extends UserState {
  final List<String> addresses;
  AddressesLoaded(this.addresses);

  @override
  List<Object> get props => [addresses];
}

class AddressesError extends UserState {
  final String errorMessage;

  AddressesError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class AddressAdding extends UserState {}

class AddressAdded extends UserState {}

class AddressAddingError extends UserState {
  final String errorMessage;

  AddressAddingError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
