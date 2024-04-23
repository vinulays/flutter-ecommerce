import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/models/cart_item.dart';
import 'package:flutter_ecommerce/screens/ShoppingCart/bloc/shopping_cart_bloc.dart';
import 'package:flutter_ecommerce/ui/cart_item_card.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  List<CartItem> items = [];
  int cartTotal = 0;

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

    return BlocBuilder<ShoppingCartBloc, ShoppingCartState>(
      builder: (context, state) {
        if (state is ShoppingCartLoadedState) {
          cartTotal = (state.cart.total * 100).truncate();
        }
        return Scaffold(
          body: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: deviceData.size.width * 0.05),
                child: Row(
                  children: [
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.of(context).pop();
                    //   },
                    //   // child: SvgPicture.asset(
                    //   //   "assets/icons/go_back.svg",
                    //   //   colorFilter: const ColorFilter.mode(
                    //   //       Colors.black, BlendMode.srcIn),
                    //   // ),
                    //   child: const Icon(
                    //     Icons.chevron_left_outlined,
                    //     size: 30,
                    //   ),
                    // ),
                    // const SizedBox(width: 10),
                    Text("Shopping Cart",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25)),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              if (state is ShoppingCartLoadedState)
                Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: state.cart.items.length,
                      itemBuilder: (BuildContext context, index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 30),
                          child: CartItemCard(
                            cartItem: CartItem(
                                name: state.cart.items[index].name,
                                imageUrl: state.cart.items[index].imageUrl,
                                price: state.cart.items[index].price,
                                quantity: state.cart.items[index].quantity,
                                color: state.cart.items[index].color,
                                size: state.cart.items[index].size),
                          ),
                        );
                      }),
                ),
              Container(
                margin: EdgeInsets.only(
                    right: deviceData.size.width * 0.05,
                    left: deviceData.size.width * 0.05,
                    bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: GoogleFonts.poppins(
                        fontSize: 19,
                      ),
                    ),
                    if (state is ShoppingCartLoadedState)
                      Text(
                        "LKR ${state.cart.total.toStringAsFixed(2)}",
                        style: GoogleFonts.poppins(
                            fontSize: 19, fontWeight: FontWeight.w700),
                      ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    right: deviceData.size.width * 0.05,
                    left: deviceData.size.width * 0.05,
                    bottom: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      // payment();
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.8),
                        ),
                      ),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(vertical: 17.88)),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                    ),
                    child: Text(
                      "Checkout",
                      style: GoogleFonts.poppins(
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
