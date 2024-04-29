import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/models/flash_sale.dart';
import 'package:flutter_ecommerce/screens/FlashSaleForm/flashsale_form.dart';
import 'package:flutter_ecommerce/screens/FlashSales/bloc/flashsale_bloc.dart';
import 'package:flutter_ecommerce/services/flashsale_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';

class FlashSaleDetails extends StatefulWidget {
  final FlashSaleService flashSaleService = FlashSaleService();

  FlashSaleDetails({super.key});

  @override
  State<FlashSaleDetails> createState() => _FlashSaleDetailsState();
}

class _FlashSaleDetailsState extends State<FlashSaleDetails> {
  List<FlashSale> flashSales = [];

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

    return BlocBuilder<FlashsaleBloc, FlashsaleState>(
      builder: (context, state) {
        if (state is FlashSalesLoaded) {
          flashSales = state.flashSales;
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                        Text("Flash sales",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25)),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const FlashSaleForm(),
                          ),
                        );
                      },
                      child: Container(
                          margin: const EdgeInsets.only(right: 20),
                          child: const Icon(
                            Icons.add,
                            size: 30,
                          )),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: flashSales.length,
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
                                    children: [
                                      Text(
                                        "Flash Sale Id: ${flashSales[index].id}",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "End time: ${Jiffy.parse(flashSales[index].endDateTime.toString()).format(pattern: "hh:mm:ss a do MMMM yyyy ")}",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Sale status:",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      if (Jiffy.parse(flashSales[index]
                                              .endDateTime
                                              .toString())
                                          .isAfter(Jiffy.now()))
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.green
                                                  .withOpacity(0.6)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 14.0,
                                                vertical: 8.0),
                                            child: Text(
                                              "On going",
                                              style: GoogleFonts.poppins(),
                                            ),
                                          ),
                                        ),
                                      if (Jiffy.parse(flashSales[index]
                                              .endDateTime
                                              .toString())
                                          .isBefore(Jiffy.now()))
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.orange
                                                  .withOpacity(0.6)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 14.0,
                                                vertical: 8.0),
                                            child: Text(
                                              "Ended",
                                              style: GoogleFonts.poppins(),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Discount : ${(flashSales[index].discountPercentage * 100).toStringAsFixed(0)}%",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }))
              ],
            ),
          ),
        );
      },
    );
  }
}
