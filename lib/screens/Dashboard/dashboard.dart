import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

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
                      "Discover",
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
            height: 30,
          ),
          // * promo banner
          Container(
            margin:
                EdgeInsets.symmetric(horizontal: deviceData.size.width * 0.05),
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
            margin:
                EdgeInsets.symmetric(horizontal: deviceData.size.width * 0.05),
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
                    color: Colors.blueAccent,
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
            margin:
                EdgeInsets.symmetric(horizontal: deviceData.size.width * 0.05),
            height: 200,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Text("Shoes"),
                  );
                },
                separatorBuilder: (contetx, _) => const SizedBox(
                      width: 10,
                    ),
                itemCount: 5),
          )
        ],
      ),
    );
  }
}
