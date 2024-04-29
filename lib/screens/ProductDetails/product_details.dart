import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/models/cart_item.dart';
import 'package:flutter_ecommerce/models/flash_sale.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/screens/Login/bloc/authentication_bloc.dart';
import 'package:flutter_ecommerce/screens/ProductDetails/bloc/product_details_bloc.dart';
import 'package:flutter_ecommerce/screens/ProductForm/product_form.dart';
import 'package:flutter_ecommerce/screens/Products/bloc/products_bloc.dart';
import 'package:flutter_ecommerce/screens/Reviews/bloc/reviews_bloc.dart';
import 'package:flutter_ecommerce/screens/Reviews/reviews.dart';
import 'package:flutter_ecommerce/screens/ShoppingCart/bloc/shopping_cart_bloc.dart';
import 'package:flutter_ecommerce/screens/ShoppingCart/shopping_cart.dart';
import 'package:flutter_ecommerce/screens/Wishlist/bloc/wishlist_bloc.dart';
import 'package:flutter_ecommerce/services/flashsale_service.dart';
import 'package:flutter_ecommerce/utils/helper_functions.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetails extends StatefulWidget {
  final FlashSaleService flashSaleService = FlashSaleService();

  ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final controller = PageController(keepPage: true);
  int? value;
  int? colorValue;

  FlashSale? flashSale;

  Future<void> getCurrentFlashSale() async {
    final flashSale2 = await widget.flashSaleService.getCurrentFlashSale();

    setState(() {
      flashSale = flashSale2;
    });
  }

  Future<bool?> _toggleWishlistProduct(
      BuildContext context, Product product, bool isLiked) async {
    try {
      context.read<WishlistBloc>().add(ToggleWishlistProduct(product));
      // * Return true to indicate success
      return true;
    } catch (e) {
      // * Return false to indicate failure
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentFlashSale();
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    Product? product;
    bool isLiked = false;

    List<Container> pages = [];

    bool isButtonDisable() {
      return value == null || colorValue == null;
    }

    bool isProductInFlashSale() {
      return flashSale != null && flashSale!.productIds.contains(product!.id);
    }

    void addToFlashSale() async {
      await widget.flashSaleService
          .addProductIdToFlashSale(flashSale!.id!, product!.id!);
    }

    void removeFromFlashSale() async {
      await widget.flashSaleService
          .removeProductFromFlashSale(flashSale!.id!, product!.id!);
    }

    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      builder: (context, state) {
        if (state is ProductLoaded) {
          product = state.product;

          pages = List.generate(
            product!.imageURLs.length,
            // ignore: avoid_unnecessary_containers
            (index) => Container(
              child: CachedNetworkImage(
                imageUrl: product!.imageURLs[index],
                imageBuilder: (context, imageProvider) => Container(
                  decoration: ShapeDecoration(
                    color: Colors.grey.shade300,
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                    shape: const RoundedRectangleBorder(),
                  ),
                ),
                placeholder: (context, url) => const SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [CircularProgressIndicator()],
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          );
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
                                GestureDetector(
                                  onTap: () async {
                                    context
                                        .read<ReviewsBloc>()
                                        .add(FetchReviewsEvent(product!.id!));

                                    showModalBottomSheet(
                                        isScrollControlled: true,
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Reviews(
                                            productId: product!.id!,
                                          );
                                        });
                                  },
                                  child: Container(
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
                                          itemPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 1.0),
                                          itemBuilder: (context, _) =>
                                              const Icon(
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
                                                  text:
                                                      "(${product!.noOfReviews.toString()} reviews)",
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
                                    if (flashSale != null &&
                                        flashSale!.productIds
                                            .contains(product!.id!))
                                      Text(
                                        "\$${product!.price.toStringAsFixed(2)}",
                                        style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            decoration:
                                                TextDecoration.lineThrough),
                                      ),
                                    if (flashSale != null &&
                                        flashSale!.productIds
                                            .contains(product!.id!))
                                      Text(
                                        "\$${(product!.price - (product!.price * flashSale!.discountPercentage)).toStringAsFixed(2)}",
                                        style: GoogleFonts.poppins(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    if (flashSale == null)
                                      Text(
                                        "\$${product!.price.toStringAsFixed(2)}",
                                        style: GoogleFonts.poppins(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    if (flashSale != null &&
                                        !flashSale!.productIds
                                            .contains(product!.id!))
                                      Text(
                                        "\$${product!.price.toStringAsFixed(2)}",
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
                                        backgroundColor: !isButtonDisable()
                                            ? MaterialStateProperty.all(
                                                Colors.black)
                                            : MaterialStateProperty.all(
                                                Colors.black.withOpacity(0.3))),
                                    onPressed: isButtonDisable()
                                        ? null
                                        : () {
                                            context
                                                .read<ShoppingCartBloc>()
                                                .add(
                                                  AddItemEvent(
                                                    CartItem(
                                                        id: product!.id!,
                                                        name: product!.title,
                                                        // * if the product is in flash sale, pass the discounted price to the cart. if not, pass the normal price
                                                        price: (flashSale !=
                                                                    null &&
                                                                flashSale!
                                                                    .productIds
                                                                    .contains(
                                                                        product!
                                                                            .id))
                                                            ? (product!.price -
                                                                (product!
                                                                        .price *
                                                                    flashSale!
                                                                        .discountPercentage))
                                                            : product!.price,
                                                        imageUrl: product!
                                                            .thumbnailURL,
                                                        quantity: 1,
                                                        size: product!
                                                            .sizes[value!],
                                                        color: product!.colors[
                                                            colorValue!]),
                                                  ),
                                                );

                                            showModalBottomSheet(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                    top: Radius.circular(20),
                                                  ),
                                                ),
                                                clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  var deviceData =
                                                      MediaQuery.of(context);

                                                  return Container(
                                                    width: double.infinity,
                                                    color: Colors.white,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            const SizedBox(
                                                              height: 40,
                                                            ),
                                                            SizedBox(
                                                              height: 130,
                                                              width: 130,
                                                              child: Image.asset(
                                                                  "assets/icons/payment-success.png"),
                                                            ),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            Text(
                                                              "Product added to cart!",
                                                              style: GoogleFonts.poppins(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                            ),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            Text(
                                                              "Thank you for adding the item to your cart :)",
                                                              style: GoogleFonts.poppins(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.5)),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ],
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets.only(
                                                              right: deviceData
                                                                      .size
                                                                      .width *
                                                                  0.05,
                                                              left: deviceData
                                                                      .size
                                                                      .width *
                                                                  0.05,
                                                              bottom: 20),
                                                          child: SizedBox(
                                                            width:
                                                                double.infinity,
                                                            child: TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pushReplacement(
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            const ShoppingCart(
                                                                      fromWhere:
                                                                          "productDetails",
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                              style:
                                                                  ButtonStyle(
                                                                shape: MaterialStateProperty
                                                                    .all<
                                                                        RoundedRectangleBorder>(
                                                                  RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            16.8),
                                                                  ),
                                                                ),
                                                                padding: MaterialStateProperty.all(
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            17.88)),
                                                                backgroundColor:
                                                                    MaterialStateProperty.all<
                                                                            Color>(
                                                                        Colors
                                                                            .black),
                                                              ),
                                                              child: Text(
                                                                "View shopping cart",
                                                                style: GoogleFonts.poppins(
                                                                    fontSize:
                                                                        19,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                });
                                          },
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
                            BlocBuilder<AuthenticationBloc,
                                AuthenticationState>(
                              builder: (context, state) {
                                if (state is AuthenticationAuthenticated) {
                                  if (state.user.role == "user") {
                                    return BlocBuilder<WishlistBloc,
                                        WishlistState>(
                                      builder: (context, state) {
                                        if (state is WishlistLoaded) {
                                          isLiked = state.wishlistProducts.any(
                                              (wishListProduct) =>
                                                  wishListProduct.id ==
                                                  product!.id);
                                        }
                                        return Container(
                                          height: 40,
                                          width: 40,
                                          margin: const EdgeInsets.only(
                                              top: 50, right: 25),
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 3, top: 1, bottom: 1),
                                            child: LikeButton(
                                              onTap: (bool isLiked) {
                                                return _toggleWishlistProduct(
                                                    context, product!, isLiked);
                                              },
                                              isLiked: isLiked,
                                              circleColor: const CircleColor(
                                                  start: Colors.red,
                                                  end: Colors.red),
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
                                        );
                                      },
                                    );
                                  } else {
                                    // * popup menu to update and delete item
                                    return PopupMenuButton<String>(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      surfaceTintColor: Colors.white,
                                      offset: const Offset(0, 10),
                                      position: PopupMenuPosition.under,
                                      itemBuilder: (BuildContext context) =>
                                          <PopupMenuEntry<String>>[
                                        PopupMenuItem<String>(
                                          value: 'update',
                                          child: Text(
                                            'Update item',
                                            style: GoogleFonts.poppins(),
                                          ),
                                        ),
                                        if (flashSale != null)
                                          PopupMenuItem<String>(
                                            value: 'flash',
                                            child: Text(
                                              isProductInFlashSale()
                                                  ? 'Remove from flash sale'
                                                  : "Add to flash sale",
                                              style: GoogleFonts.poppins(),
                                            ),
                                          ),
                                        PopupMenuItem<String>(
                                          value: 'delete',
                                          child: Text(
                                            'Delete item',
                                            style: GoogleFonts.poppins(
                                                color: Colors.red),
                                          ),
                                        ),
                                      ],
                                      onSelected: (String value) {
                                        switch (value) {
                                          case 'update':
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductForm(
                                                  product: product,
                                                  isUpdate: true,
                                                ),
                                              ),
                                            );
                                            break;
                                          case 'flash':
                                            (isProductInFlashSale())
                                                ? removeFromFlashSale()
                                                : addToFlashSale();
                                            break;
                                          case 'delete':
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    backgroundColor:
                                                        Colors.white,
                                                    title: Text(
                                                      "Delete product",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                    ),
                                                    content: Text(
                                                      "This action cannot be undone. Do you really want to delete this product?",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 14),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text(
                                                            "No",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontSize:
                                                                        14),
                                                          )),
                                                      TextButton(
                                                          onPressed: () async {
                                                            context
                                                                .read<
                                                                    ProductsBloc>()
                                                                .add(DeleteProductEvent(
                                                                    product!
                                                                        .id!));

                                                            // * going back to home screen after deletion
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text(
                                                            "Yes",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontSize:
                                                                        14),
                                                          )),
                                                    ],
                                                  );
                                                });
                                            break;
                                        }
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        margin: const EdgeInsets.only(
                                            top: 50, right: 25),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons.more_vert,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                } else {
                                  return Container();
                                }
                              },
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
