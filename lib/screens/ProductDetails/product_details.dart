import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/screens/ProductDetails/bloc/product_details_bloc.dart';
import 'package:flutter_ecommerce/utils/helper_functions.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final controller = PageController(keepPage: true);
  int? value = 0;
  int? colorValue = 0;

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    Product? product;

    List<Container> pages = [];

    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      builder: (context, state) {
        if (state is ProductLoaded) {
          product = state.product;

          pages = List.generate(
              product!.imageURLs.length,
              (index) => Container(
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                          image: NetworkImage(product!.imageURLs[index]),
                          fit: BoxFit.cover),
                      color: Colors.grey.shade300,
                    ),
                  ));
        }

        return Scaffold(
          body: (state is ProductLoaded)
              ? Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ListView(padding: EdgeInsets.zero, children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    SizedBox(
                                      height: deviceSize.height * 0.5,
                                      child: PageView.builder(
                                          itemCount: pages.length,
                                          controller: controller,
                                          itemBuilder: (_, index) {
                                            return pages[index % pages.length];
                                          }),
                                    ),
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 18),
                                          child: SmoothPageIndicator(
                                            controller: controller,
                                            count: pages.length,
                                            effect: const ExpandingDotsEffect(
                                                expansionFactor: 3,
                                                spacing: 5,
                                                dotColor: Colors.white70,
                                                activeDotColor: Colors.white,
                                                dotHeight: 5,
                                                dotWidth: 7),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                // * product rating
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: deviceSize.width * 0.03),
                                  child: Row(
                                    children: [
                                      RatingBar.builder(
                                        ignoreGestures: true,
                                        itemSize: 20,
                                        glow: false,
                                        initialRating: product!.rating,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: false,
                                        itemCount: 5,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 1.0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {},
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                                text: "${product!.rating} ",
                                                style: GoogleFonts.poppins(
                                                    fontWeight:
                                                        FontWeight.w700)),
                                            TextSpan(
                                                text: "(1201 reviews)",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                    fontWeight:
                                                        FontWeight.w700)),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                // * product title
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: deviceSize.width * 0.03),
                                  child: Text(
                                    product!.title,
                                    style: GoogleFonts.poppins(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                // * product description
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: deviceSize.width * 0.03),
                                  child: ReadMoreText(
                                    style: GoogleFonts.poppins(),
                                    product!.description,
                                    trimMode: TrimMode.Line,
                                    trimLines: 4,
                                    colorClickableText: Colors.black,
                                    trimCollapsedText: 'Show more',
                                    trimExpandedText: 'Show less',
                                    lessStyle: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold),
                                    moreStyle: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                // * choose size & color

                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: deviceSize.width * 0.03),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Choose Size",
                                        style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Wrap(
                                        spacing: 5,
                                        children: List.generate(
                                            product!.sizes.length, (index) {
                                          return ChoiceChip(
                                            selectedColor: Colors.black,
                                            showCheckmark: false,
                                            labelStyle: GoogleFonts.poppins(
                                                color: value == index
                                                    ? Colors.white
                                                    : Colors.black),
                                            shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                    color: Colors.grey
                                                        .withOpacity(0.2)),
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            label: Text(product!.sizes[index]),
                                            selected: value == index,
                                            onSelected: (bool selected) {
                                              setState(() {
                                                value = selected ? index : null;
                                              });
                                            },
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 13,
                                ),
                                // * select color
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: deviceSize.width * 0.03),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Choose Color",
                                        style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Wrap(
                                        spacing: 3,
                                        children: List.generate(
                                            product!.colors.length, (index) {
                                          return Theme(
                                            data: Theme.of(context).copyWith(
                                                canvasColor:
                                                    HelperFunctions.getColor(
                                                        product!
                                                            .colors[index])),
                                            child: ChoiceChip(
                                              showCheckmark: false,
                                              selectedColor:
                                                  HelperFunctions.getColor(
                                                      product!.colors[index]),
                                              backgroundColor:
                                                  HelperFunctions.getColor(
                                                      product!.colors[index]),
                                              shape: CircleBorder(
                                                  side: BorderSide(
                                                      width: 2,
                                                      color: (colorValue !=
                                                              index)
                                                          ? Colors.grey
                                                              .withOpacity(0.2)
                                                          : Colors.black)),
                                              label: const Text(''),
                                              selected: colorValue == index,
                                              onSelected: (bool selected) {
                                                setState(() {
                                                  colorValue =
                                                      selected ? index : null;
                                                });
                                              },
                                            ),
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                )
                              ],
                            ),
                          ]),
                        ),
                        // * Price & Add to cart
                        Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black,
                                    offset: Offset(0.0, 5.0),
                                    blurRadius: 4.5)
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: deviceSize.width * 0.03,
                                    vertical: deviceSize.width * 0.05),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "\$200.00",
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          decoration:
                                              TextDecoration.lineThrough),
                                    ),
                                    Text(
                                      "\$150.00",
                                      style: GoogleFonts.poppins(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: deviceSize.width * 0.03,
                                    vertical: deviceSize.width * 0.05),
                                child: TextButton.icon(
                                    style: ButtonStyle(
                                        padding: MaterialStateProperty.all(
                                            const EdgeInsets.symmetric(
                                                horizontal: 30, vertical: 15)),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.black)),
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.shopping_cart_outlined,
                                      color: Colors.white,
                                    ),
                                    label: Text(
                                      "Add to cart",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white),
                                    )),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Positioned.fill(
                      // top: 50,
                      // left: 25,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              margin: const EdgeInsets.only(top: 50, left: 25),
                              decoration: const BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle),
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Icon(
                                    Icons.chevron_left,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                            // * back and like button
                            Container(
                              height: 40,
                              width: 40,
                              margin: const EdgeInsets.only(top: 50, right: 25),
                              decoration: const BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 3, top: 1, bottom: 1),
                                child: LikeButton(
                                  circleColor: const CircleColor(
                                      start: Colors.red, end: Colors.red),
                                  bubblesColor: const BubblesColor(
                                    dotPrimaryColor: Colors.red,
                                    dotSecondaryColor: Colors.red,
                                  ),
                                  likeBuilder: (bool isLiked) {
                                    if (isLiked) {
                                      return const Icon(
                                        CupertinoIcons.heart_fill,
                                        color: Colors.red,
                                        size: 20,
                                      );
                                    } else {
                                      return const Icon(
                                        CupertinoIcons.heart,
                                        color: Colors.black,
                                        size: 20,
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : (state is ProductLoading)
                  ? const Center(
                      child: CircularProgressIndicator(
                        strokeCap: StrokeCap.round,
                        strokeWidth: 5,
                        color: Color(0xff75A488),
                      ),
                    )
                  : Container(),
        );
      },
    );
  }
}
