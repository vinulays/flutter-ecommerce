import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/screens/ProductDetails/bloc/product_details_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final controller = PageController(keepPage: true);

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
              ? Column(
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
                              margin: const EdgeInsets.only(bottom: 18),
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
                                  margin:
                                      const EdgeInsets.only(top: 50, left: 25),
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle),
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
                                Container(
                                  height: 40,
                                  width: 40,
                                  margin:
                                      const EdgeInsets.only(top: 50, right: 25),
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle),
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
