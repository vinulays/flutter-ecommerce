import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/models/flash_sale.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/screens/CategoryDetails/bloc/category_details_bloc.dart';
import 'package:flutter_ecommerce/screens/CategoryDetails/category_details.dart';
import 'package:flutter_ecommerce/screens/Login/bloc/authentication_bloc.dart';
import 'package:flutter_ecommerce/screens/Products/bloc/products_bloc.dart';
import 'package:flutter_ecommerce/services/flashsale_service.dart';
import 'package:flutter_ecommerce/ui/product_card.dart';
import 'package:flutter_ecommerce/ui/product_search_delegate.dart';
import 'package:flutter_ecommerce/utils/product_categories.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:slide_countdown/slide_countdown.dart';

class Dashboard extends StatefulWidget {
  final FlashSaleService flashSaleService = FlashSaleService();
  Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  FlashSale? flashSale;

  Future<void> getCurrentFlashSale() async {
    final flashSale2 = await widget.flashSaleService.getCurrentFlashSale();

    setState(() {
      flashSale = flashSale2;
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentFlashSale();
  }

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 55,
          ),
          Container(
            margin:
                EdgeInsets.symmetric(horizontal: deviceData.size.width * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<AuthenticationBloc, AuthenticationState>(
                      builder: (context, state) {
                        if (state is AuthenticationAuthenticated) {
                          return Text(
                            "Hi, ${state.user.username}👋",
                            style: GoogleFonts.poppins(
                                fontSize: 25, fontWeight: FontWeight.w700),
                          );
                        }
                        return Container();
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Find anything what you want!",
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await showSearch(
                            context: context,
                            delegate: ProductSearchDelegate());
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 20),
                        child: Image.asset(
                          "assets/icons/search.png",
                          height: 30,
                          width: 30,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // * promo banner
          Expanded(
            child: ListView(
              children: [
                GestureDetector(
                  onTap: () {
                    context.read<CategoryDetailsBloc>().add(
                        FetchCategoryDetailsEvent(productCategories[0].id));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoryDetails(
                                  categoryId: productCategories[0].id,
                                  categoryName: productCategories[0].name,
                                  bannerURL: productCategories[0].bannerURL,
                                )));
                  },
                  child: Stack(
                    children: [
                      ShaderMask(
                        blendMode: BlendMode.srcATop,
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            begin: const Alignment(0.01, 0),
                            end: const Alignment(0.015, 1.1),
                            colors: [Colors.black.withOpacity(0), Colors.black],
                          ).createShader(bounds);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: deviceData.size.width * 0.05),
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  AssetImage("assets/images/promo-banner.jpg"),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 25,
                        left: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: deviceData.size.width * 0.05),
                              child: Text(
                                "Air Jordan 50% Off",
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: deviceData.size.width * 0.05),
                              child: Text(
                                "Seasonal Offer",
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 25,
                        right: 20,
                        child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: deviceData.size.width * 0.05),
                            child: const Icon(
                              size: 40,
                              Icons.arrow_right_sharp,
                              color: Colors.white,
                            )),
                      )
                    ],
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),
                // * browser categories
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: deviceData.size.width * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Browse Categories",
                        style: GoogleFonts.poppins(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: deviceData.size.width * 0.05),
                  height: 85,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            context.read<CategoryDetailsBloc>().add(
                                FetchCategoryDetailsEvent(
                                    productCategories[index].id));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CategoryDetails(
                                          categoryId:
                                              productCategories[index].id,
                                          categoryName:
                                              productCategories[index].name,
                                          bannerURL: productCategories[index]
                                              .bannerURL,
                                        )));
                          },
                          child: Column(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: const BoxDecoration(
                                  color: Color(0xffF5F5FF),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Image.asset(
                                    productCategories[index].iconURL,
                                    height: 45,
                                    width: 45,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                productCategories[index].name,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (contetx, _) => const SizedBox(
                            width: 25,
                          ),
                      itemCount: productCategories.length),
                ),
                if (flashSale != null)
                  const SizedBox(
                    height: 35,
                  ),
                // * Flash sale
                if (flashSale != null)
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: deviceData.size.width * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Flash Sale",
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        Row(
                          children: [
                            Text(
                              "Closing in:",
                              style: GoogleFonts.poppins(),
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            SlideCountdownSeparated(
                              padding: const EdgeInsets.all(4),
                              separator: "",
                              duration: Duration(
                                  seconds: Jiffy.parse(
                                          flashSale!.endDateTime.toString())
                                      .diff(
                                          Jiffy.parse(
                                              DateTime.now().toString()),
                                          unit: Unit.second)
                                      .toInt()),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                const SizedBox(
                  height: 20,
                ),

                if (flashSale != null)
                  BlocBuilder<ProductsBloc, ProductsState>(
                    builder: (context, state) {
                      if (state is ProductsLoaded) {
                        final filteredProducts = state.products
                            .where((product) =>
                                flashSale!.productIds.contains(product.id))
                            .toList();

                        return Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: deviceData.size.width * 0.05),
                          child: Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            runSpacing: 10,
                            children:
                                List.generate(filteredProducts.length, (index) {
                              return ProductCard(
                                  discount: flashSale?.discountPercentage,
                                  product: filteredProducts[index]);
                            }),
                          ),
                        );
                      } else if (state is ProductsLoading) {
                        Container();
                      }

                      return Container();
                    },
                  ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: deviceData.size.width * 0.05),
                  child: Text(
                    "Latest Products",
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<ProductsBloc, ProductsState>(
                  builder: (context, state) {
                    if (state is ProductsLoaded) {
                      // * Displaying items created 10 days ago and later
                      final currentTime = Jiffy.now();
                      final List<Product> validProducts =
                          state.products.where((product) {
                        final productTime =
                            Jiffy.parse(product.createdAt.toString());
                        final daysDifference =
                            currentTime.diff(productTime, unit: Unit.day);
                        return daysDifference <= 10;
                      }).toList();

                      return Container(
                        margin: EdgeInsets.only(
                            left: deviceData.size.width * 0.05,
                            right: deviceData.size.width * 0.05,
                            bottom: 20),
                        child: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          runSpacing: 10,
                          children:
                              List.generate(validProducts.length, (index) {
                            return ProductCard(
                                discount: (flashSale != null &&
                                        flashSale!.productIds
                                            .contains(validProducts[index].id))
                                    ? flashSale!.discountPercentage
                                    : null,
                                product: validProducts[index]);
                          }),
                        ),
                      );
                    } else if (state is ProductsLoading) {
                      Container();
                    }

                    return Container();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
