import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/models/cart_item.dart';
import 'package:flutter_ecommerce/screens/ShoppingCart/bloc/shopping_cart_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CartItemCard extends StatefulWidget {
  final CartItem cartItem;
  const CartItemCard({super.key, required this.cartItem});

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

class _CartItemCardState extends State<CartItemCard> {
  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: deviceData.size.width * 0.03),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: CachedNetworkImage(
                    imageUrl: widget.cartItem.imageUrl,
                    imageBuilder: (context, imageProvider) => Container(
                      height: 120,
                      width: 120,
                      decoration: ShapeDecoration(
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    placeholder: (context, url) => const SizedBox(
                      height: 120,
                      width: 120,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [CircularProgressIndicator()],
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: SizedBox(
                    height: 120,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.cartItem.name,
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Color: ${widget.cartItem.color.capitalize()}, Size: ${widget.cartItem.size}",
                              style: GoogleFonts.poppins(),
                            ),
                          ],
                        ),
                        SizedBox(
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context.read<ShoppingCartBloc>().add(
                                      RemoveItemQuantityEvent(
                                          widget.cartItem.name,
                                          widget.cartItem.color,
                                          widget.cartItem.size));
                                },
                                child: const Icon(Icons.remove_circle_outline),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${widget.cartItem.quantity}",
                                style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black.withOpacity(0.4)),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  context.read<ShoppingCartBloc>().add(
                                      AddItemQuantityEvent(
                                          widget.cartItem.name,
                                          widget.cartItem.color,
                                          widget.cartItem.size));
                                },
                                child: const Icon(Icons.add_circle_outline),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    context.read<ShoppingCartBloc>().add(RemoveItemEvent(
                        widget.cartItem.name,
                        widget.cartItem.color,
                        widget.cartItem.size));
                  },
                  child: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
                Text(
                  "\$${widget.cartItem.price.toStringAsFixed(2)}",
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black.withOpacity(0.4)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
