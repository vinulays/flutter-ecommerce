import 'package:flutter_ecommerce/services/user_service.dart';

class UserRepository {
  final UserService _userService;

  UserRepository({required UserService userService})
      : _userService = userService;

  Future<List<String>> getUserAddresses() async {
    return _userService.getUserAddresses();
  }

  Future<void> addUserAddress(String address) async {
    await _userService.addAddress(address);
  }
}
