import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ecommerce/utils/product_categories.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slide_countdown/slide_countdown.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
                    Text(
                      "Hi, Vinula👋",
                      style: GoogleFonts.poppins(
                          fontSize: 28, fontWeight: FontWeight.w700),
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
                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: Image.asset(
                        "assets/icons/shopping-cart.png",
                        height: 30,
                        width: 30,
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
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: deviceData.size.width * 0.05),
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/promo-banner.jpg"),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
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
                      Text(
                        "See all",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
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
                const SizedBox(
                  height: 20,
                ),
                // * Flash sale
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
                          // const SlideCountdownSeparated(
                          //   padding: EdgeInsets.all(4),
                          //   separator: "",
                          //   duration: Duration(hours: 12),
                          // )
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // * Flash sale items

                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: deviceData.size.width * 0.05),
                  child: Wrap(
                    spacing: 30,
                    runSpacing: 10,
                    children: List.generate(6, (index) {
                      return GestureDetector(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // * item thumbnail
                            Container(
                              height: 170,
                              width: 170,
                              decoration: BoxDecoration(
                                color: const Color(0xff7279F6),
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                  image: AssetImage("assets/images/shoe.png"),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: 160,
                              child: Text(
                                "Air Jordan XXX USA Version",
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            SizedBox(
                              width: 160,
                              child: Text(
                                "\$120.00",
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                    color: Colors.black.withOpacity(0.5),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
