import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/order.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/services/product_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';

class OrderDetails extends StatelessWidget {
  final ProductService productService = ProductService(
      firestore: FirebaseFirestore.instance, storage: FirebaseStorage.instance);
  final OrderLocal order;
  OrderDetails({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

    // * getting the details extracted from the address format (recipient name, contact number & address)
    List<String> parts = order.address.split('-');
    String addressText = parts[0].trim();
    String details = parts[1].trim();

    List<String> detailParts = details.split('#');
    String personName = detailParts[0].trim();
    String contactNumber = detailParts[1].trim();

    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: deviceData.size.width * 0.03),
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
                Text("Order Details",
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
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border:
                            Border.all(color: Colors.black.withOpacity(0.2))),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Order ID",
                                style: GoogleFonts.poppins(fontSize: 16),
                              ),
                              Text(
                                order.id.toString(),
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Colors.black.withOpacity(0.6)),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Order Placed",
                                style: GoogleFonts.poppins(fontSize: 16),
                              ),
                              Text(
                                Jiffy.parse(order.createdAt.toString())
                                    .format(pattern: "do MMMM yyyy"),
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Colors.black.withOpacity(0.6)),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total",
                                style: GoogleFonts.poppins(fontSize: 16),
                              ),
                              Text(
                                "\$${order.cost.toStringAsFixed(2)}",
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Colors.black.withOpacity(0.6)),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Order status",
                                style: GoogleFonts.poppins(fontSize: 16),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.orange.withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 8),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Processing",
                                        style: GoogleFonts.poppins(
                                            fontSize: 16, color: Colors.black),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Icon(
                                        Icons.schedule_outlined,
                                        size: 20,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Divider(
                            thickness: 0.4,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            personName,
                            style: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.home_outlined,
                                color: Colors.black.withOpacity(0.6),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                width: 270,
                                child: Text(
                                  addressText,
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: Colors.black.withOpacity(0.6)),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.phone_outlined,
                                size: 21,
                                color: Colors.black.withOpacity(0.6),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                width: 270,
                                child: Text(
                                  contactNumber,
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: Colors.black.withOpacity(0.6)),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Divider(
                            thickness: 0.4,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Payment Method",
                                style: GoogleFonts.poppins(fontSize: 16),
                              ),
                              Text(
                                order.paymentMethod,
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Colors.black.withOpacity(0.6)),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // * Order products
                  Text(
                    "Ordered items",
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: order.productQuantityMap.length,
                      itemBuilder: (BuildContext context, productIndex) {
                        final productId = order.productQuantityMap.keys
                            .elementAt(productIndex);
                        final quantity = order.productQuantityMap[productId];
                        Future<Product> productFuture =
                            productService.getProductById(productId);

                        return FutureBuilder(
                            future: productFuture,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                Product product = snapshot.data!;

                                return Container(
                                  margin: const EdgeInsets.only(bottom: 20),
                                  child: Row(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: product.thumbnailURL,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          height: 100,
                                          width: 100,
                                          decoration: ShapeDecoration(
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10))),
                                        ),
                                        placeholder: (context, url) =>
                                            const SizedBox(
                                          height: 100,
                                          width: 100,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              CircularProgressIndicator()
                                            ],
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              product.title,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700),
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
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 10),
                                                  child: Text(
                                                    "Qty: $quantity",
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.black
                                                            .withOpacity(0.5),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500),
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
                                return Text('Error: ${snapshot.error}');
                              }

                              return Container();
                            });
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
