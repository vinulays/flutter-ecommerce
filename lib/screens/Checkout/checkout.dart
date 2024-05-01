import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/models/cart_item.dart';
import 'package:flutter_ecommerce/models/order.dart';
import 'package:flutter_ecommerce/screens/OrderSuccess/order_success.dart';
import 'package:flutter_ecommerce/screens/Orders/bloc/orders_bloc.dart';
import 'package:flutter_ecommerce/screens/Profile/bloc/user_bloc.dart';
import 'package:flutter_ecommerce/screens/ShoppingCart/bloc/shopping_cart_bloc.dart';
import 'package:flutter_ecommerce/services/promocode_service.dart';
import 'package:flutter_ecommerce/ui/address_bottom_sheet.dart';
import 'package:flutter_ecommerce/ui/cart_item_card.dart';
import 'package:flutter_ecommerce/ui/payment_methods_bottom_sheet.dart';
import 'package:google_fonts/google_fonts.dart';

class Checkout extends StatefulWidget {
  final PromoCodeService promoCodeService = PromoCodeService();
  Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  // * Selected address & payment method values from the menus.
  String selectedAddress = "Select an Address";
  String selectedPaymentMethod = "Select a Payment Method";

  // * total cost, discount, & shipping cost of the order. (Shipping cost is manually set to $30).
  double totalCost = 0;
  double discount = 0;
  double shippingCost = 30;

  // * text controller to get the value of the user input for promo code.
  final promoCodeController = TextEditingController();

  bool totalFetched = false;

  // * Apply selected address & payment method to variables.
  void applyAddress(String address) {
    setState(() {
      selectedAddress = address;
    });
  }

  void applyPaymentMethod(String paymentMethod) {
    setState(() {
      selectedPaymentMethod = paymentMethod;
    });
  }

  // * applies the discount and update discount amount & total cost of the order.
  void applyDiscount(
      double totalCostInput, double shippingCost, String promoCode) async {
    // * getting to know if the user has already used the promo code from firebase.
    // * each promo code document in firebase has an array of used user ids.
    bool isUserHasUsedPromoCode =
        await widget.promoCodeService.hasUserUsedPromoCode(promoCode);

    // * if user hasn't used the promo code already, apply the discount.
    if (!isUserHasUsedPromoCode) {
      // * getting the discount value from the firebase. (10% = 0.1, 20% = 0.2)
      double promoCodeDiscount =
          await widget.promoCodeService.getDiscountAmount(promoCode);

      double discountPercentage = promoCodeDiscount;
      double discountAmount = totalCostInput * discountPercentage;

      double discountedTotalCost = totalCostInput - discountAmount;

      setState(() {
        discount = discountAmount;
        totalCost = discountedTotalCost;
      });

      // * adding the currently logged user id to the promo code in firebase.
      await widget.promoCodeService.usePromoCode(promoCode);
    }
  }

  @override
  void dispose() {
    promoCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

    // * using to disable the pay button when user not selected any of address or payment method.
    bool isButtonDisable() {
      return selectedAddress == "Select an Address" ||
          selectedPaymentMethod == "Select a Payment Method";
    }

    return BlocBuilder<ShoppingCartBloc, ShoppingCartState>(
      builder: (context, state) {
        if (state is ShoppingCartLoadedState) {
          if (!totalFetched) {
            totalCost = state.cart.total + shippingCost;
            totalFetched = true;
          }

          return Scaffold(
            body: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: deviceData.size.width * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(
                          Icons.chevron_left_outlined,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text("Checkout",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25)),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // * cart items
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        Text(
                          "My Cart",
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        // * cart items
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: state.cart.items.length,
                            itemBuilder: (BuildContext context, index) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                child: CartItemCard(
                                  fromWhere: "checkout",
                                  cartItem: CartItem(
                                      id: state.cart.items[index].id,
                                      name: state.cart.items[index].name,
                                      imageUrl:
                                          state.cart.items[index].imageUrl,
                                      price: state.cart.items[index].price,
                                      quantity:
                                          state.cart.items[index].quantity,
                                      color: state.cart.items[index].color,
                                      size: state.cart.items[index].size),
                                ),
                              );
                            }),
                        Text(
                          "Address",
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            // * getting addresses for the current user
                            context.read<UserBloc>().add(FetchAddresses());

                            // * bottom sheet to select address
                            showModalBottomSheet(
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                context: context,
                                builder: (BuildContext context) {
                                  return Wrap(
                                    children: [
                                      AddressBottomSheet(
                                        initialSelectedAddress: selectedAddress,
                                        applyAddressCallback: applyAddress,
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey.withOpacity(0.1),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 17),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        color: Colors.black.withOpacity(0.5),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      SizedBox(
                                        width: 250,
                                        child: Text(
                                          overflow: TextOverflow.ellipsis,
                                          selectedAddress,
                                          style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              color: Colors.black
                                                  .withOpacity(0.8)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(Icons.chevron_right_rounded,
                                      size: 30,
                                      color: Colors.black.withOpacity(0.6))
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Payment method",
                          style: GoogleFonts.poppins(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            context.read<UserBloc>().add(FetchAddresses());

                            // * bottom sheet to select payment method
                            showModalBottomSheet(
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                context: context,
                                builder: (BuildContext context) {
                                  return Wrap(
                                    children: [
                                      PaymentMethodBottomSheet(
                                        initialSelectedPaymentMethod:
                                            selectedPaymentMethod,
                                        applyPaymentMethodCallback:
                                            applyPaymentMethod,
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey.withOpacity(0.1),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 17),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.credit_card,
                                        color: Colors.black.withOpacity(0.5),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        selectedPaymentMethod,
                                        style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            color:
                                                Colors.black.withOpacity(0.8)),
                                      ),
                                    ],
                                  ),
                                  Icon(Icons.chevron_right_rounded,
                                      size: 30,
                                      color: Colors.black.withOpacity(0.6))
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: promoCodeController,
                          decoration: InputDecoration(
                              suffixIcon: Container(
                                margin: const EdgeInsets.only(right: 10),
                                width: 90,
                                child: TextButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.black)),
                                  onPressed: () {
                                    applyDiscount(totalCost, shippingCost,
                                        promoCodeController.text);
                                  },
                                  child: Text(
                                    "Apply",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              prefix: Container(
                                width: 20,
                              ),
                              contentPadding: EdgeInsets.zero,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black.withOpacity(0.15)),
                                  borderRadius: BorderRadius.circular(20)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black.withOpacity(0.15)),
                                  borderRadius: BorderRadius.circular(20)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black.withOpacity(0.15)),
                                  borderRadius: BorderRadius.circular(20)),
                              hintStyle: GoogleFonts.poppins(
                                height: 4,
                                color: Colors.black.withOpacity(0.8),
                              ),
                              hintText: "Have a promo code?"),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Order info",
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Subtotal",
                              style: GoogleFonts.poppins(fontSize: 16),
                            ),
                            Text(
                              "\$${state.cart.total.toStringAsFixed(2)}",
                              style: GoogleFonts.poppins(fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Your discount",
                              style: GoogleFonts.poppins(fontSize: 16),
                            ),
                            Text(
                              "-\$${discount.toStringAsFixed(2)}",
                              style: GoogleFonts.poppins(fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Shipping Cost",
                              style: GoogleFonts.poppins(fontSize: 16),
                            ),
                            Text(
                              "\$${shippingCost.toStringAsFixed(2)}",
                              style: GoogleFonts.poppins(fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Cost",
                              style: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "\$${totalCost.toStringAsFixed(2)}",
                              style: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: isButtonDisable()
                                  ? null
                                  : () async {
                                      // * creating order object.
                                      // * a map is used to add item id and their quantity.
                                      OrderLocal order = OrderLocal(
                                          customerId: FirebaseAuth
                                              .instance.currentUser!.uid,
                                          address: selectedAddress,
                                          paymentMethod: selectedPaymentMethod,
                                          productQuantityMap: state.cart.items
                                              .fold<Map<String, int>>(
                                            {},
                                            (map, item) {
                                              map[item.id] = item.quantity;
                                              return map;
                                            },
                                          ),
                                          cost: totalCost,
                                          createdAt: DateTime.now());

                                      context
                                          .read<OrdersBloc>()
                                          .add(AddOrderEvent(order));

                                      context
                                          .read<ShoppingCartBloc>()
                                          .add(ResetCartEvent());

                                      // * navigate to order success page.
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const OrderSuccess(),
                                        ),
                                      );
                                    },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.8),
                                  ),
                                ),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                        vertical: 17.88)),
                                backgroundColor: isButtonDisable()
                                    ? MaterialStateProperty.all<Color>(
                                        Colors.black.withOpacity(0.5))
                                    : MaterialStateProperty.all(Colors.black),
                              ),
                              child: Text(
                                "Pay \$${totalCost.toStringAsFixed(2)}",
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
                  )
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
