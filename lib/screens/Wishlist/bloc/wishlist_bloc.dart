import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/repositories/auth_repository.dart';
import 'package:flutter_ecommerce/repositories/wishlist_repository.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final WishListRepository _wishListRepository;
  final AuthRepository _authRepository;
  WishlistBloc(
      {required WishListRepository wishListRepository,
      required AuthRepository authRepository})
      : _wishListRepository = wishListRepository,
        _authRepository = authRepository,
        super(WishlistInitial()) {
    on<FetchWishListEvent>((event, emit) async {
      emit(WishlistLoading());

      try {
        User? user = await _authRepository.getCurrentUser();

        final List<Product> wishlistProducts =
            await _wishListRepository.getWishListProducts(user!.uid);

        emit(WishlistLoaded(wishlistProducts));
      } catch (e) {
        emit(WishlistLoadingError("Failed to fetch wishlist: $e"));
      }
    });

    on<ToggleWishlistProduct>((event, emit) async {
      try {
        User? user = await _authRepository.getCurrentUser();

        await _wishListRepository.toggleProductInWishlist(
            user!.uid, event.product.id!);

        final List<Product> wishlistProducts =
            await _wishListRepository.getWishListProducts(user.uid);

        emit(WishlistLoaded(wishlistProducts));
      } catch (e) {
        emit(WishlistLoadingError("Failed to toggle product: $e"));
      }
    });
  }
}
