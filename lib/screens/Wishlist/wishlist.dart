import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Container(
            margin:
                EdgeInsets.symmetric(horizontal: deviceData.size.width * 0.05),
            child: Row(
              children: [
                Text("Wishlist",
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25)),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
