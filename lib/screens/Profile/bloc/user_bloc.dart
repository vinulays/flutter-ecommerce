import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/repositories/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(UserInitial()) {
    on<FetchAddresses>((event, emit) async {
      emit(AddressesLoading());

      try {
        final addresses = await _userRepository.getUserAddresses();
        emit(AddressesLoaded(addresses));
      } catch (e) {
        emit(AddressesError("Failed to fetch address: $e"));
      }
    });

    on<AddAddress>((event, emit) async {
      emit(AddressAdding());

      try {
        await _userRepository.addUserAddress(event.address);
        emit(AddressAdded());

        add(FetchAddresses());
      } catch (e) {
        emit(AddressAddingError("Failed to add address: $e"));
      }
    });
  }
}
