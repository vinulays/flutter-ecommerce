import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/models/order.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/screens/OrderDetails/order_details.dart';
import 'package:flutter_ecommerce/screens/Orders/bloc/orders_bloc.dart';
import 'package:flutter_ecommerce/services/product_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';

class Orders extends StatefulWidget {
  final ProductService productService = ProductService(
      firestore: FirebaseFirestore.instance, storage: FirebaseStorage.instance);
  Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<OrderLocal> orders = [];

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) {
        if (state is OrdersLoaded) {
          orders = state.orders;
        }
        return Scaffold(
          body: Container(
            margin:
                EdgeInsets.symmetric(horizontal: deviceData.size.width * 0.03),
            child: Column(
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
                    Text("My Orders",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25)),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: orders.length,
                      itemBuilder: (BuildContext context, index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.2))),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Order Date: ${Jiffy.parse(orders[index].createdAt.toString()).format(pattern: "do MMMM")}",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "(${orders[index].productQuantityMap.length} items)",
                                          style: GoogleFonts.poppins(
                                              color: Colors.black
                                                  .withOpacity(0.5)),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          "\$${orders[index].cost.toStringAsFixed(2)}",
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Divider(
                                  thickness: 0.5,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    itemCount:
                                        orders[index].productQuantityMap.length,
                                    itemBuilder:
                                        (BuildContext context, productIndex) {
                                      final productId = orders[index]
                                          .productQuantityMap
                                          .keys
                                          .elementAt(productIndex);
                                      final quantity = orders[index]
                                          .productQuantityMap[productId];
                                      Future<Product> productFuture = widget
                                          .productService
                                          .getProductById(productId);

                                      return FutureBuilder(
                                          future: productFuture,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              Product product = snapshot.data!;

                                              return Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 20),
                                                child: Row(
                                                  children: [
                                                    CachedNetworkImage(
                                                      imageUrl:
                                                          product.thumbnailURL,
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          Container(
                                                        height: 100,
                                                        width: 100,
                                                        decoration: ShapeDecoration(
                                                            image: DecorationImage(
                                                                image:
                                                                    imageProvider,
                                                                fit: BoxFit
                                                                    .cover),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10))),
                                                      ),
                                                      placeholder:
                                                          (context, url) =>
                                                              const SizedBox(
                                                        height: 100,
                                                        width: 100,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            CircularProgressIndicator()
                                                          ],
                                                        ),
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          const Icon(
                                                              Icons.error),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            product.title,
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                          ),
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "\$${product.price.toStringAsFixed(2)}",
                                                                style: GoogleFonts.poppins(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            10),
                                                                child: Text(
                                                                  "Qty: $quantity",
                                                                  style: GoogleFonts.poppins(
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.5),
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            } else if (snapshot.hasError) {
                                              return Text(
                                                  'Error: ${snapshot.error}');
                                            }

                                            return Container();
                                          });
                                    }),
                                const SizedBox(
                                  height: 5,
                                ),
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => OrderDetails(
                                                order: orders[index],
                                              )),
                                    );
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "View All",
                                        style:
                                            GoogleFonts.poppins(fontSize: 15),
                                      ),
                                      const Icon(
                                        Icons.chevron_right_outlined,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
