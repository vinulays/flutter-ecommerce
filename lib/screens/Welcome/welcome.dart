import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/screens/Login/login.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final _introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: _introKey,
      pages: [
        PageViewModel(
          titleWidget: Container(
            margin: const EdgeInsets.only(top: 65),
            child: SvgPicture.asset(
              "assets/images/onboard-1.svg",
              height: 350,
              width: 350,
            ),
          ),
          bodyWidget: Container(
            margin: const EdgeInsets.only(top: 30, right: 20, left: 20),
            child: Column(
              children: [
                Text(
                  textAlign: TextAlign.center,
                  "Choose you product",
                  style: GoogleFonts.poppins(fontSize: 30),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  textAlign: TextAlign.center,
                  "Welcome to a World of limitless Choices - Your Perfect Product Awaits",
                  style: GoogleFonts.poppins(fontSize: 14, height: 1.6),
                ),
              ],
            ),
          ),
        ),
        PageViewModel(
          titleWidget: Container(
            margin: const EdgeInsets.only(top: 65, left: 10),
            child: SvgPicture.asset(
              "assets/images/onboard-2.svg",
              height: 350,
              width: 350,
            ),
          ),
          bodyWidget: Container(
            margin: const EdgeInsets.only(top: 30, right: 20, left: 20),
            child: Column(
              children: [
                Text(
                  textAlign: TextAlign.center,
                  "Payment Methods",
                  style: GoogleFonts.poppins(fontSize: 30),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  textAlign: TextAlign.center,
                  "For Seamless transactions, We offer wide range of payment methods.",
                  style: GoogleFonts.poppins(fontSize: 14, height: 1.6),
                ),
              ],
            ),
          ),
        ),
        PageViewModel(
          titleWidget: Container(
            margin: const EdgeInsets.only(top: 65, left: 10),
            child: SvgPicture.asset(
              "assets/images/onboard-3.svg",
              height: 350,
              width: 350,
            ),
          ),
          bodyWidget: Container(
            margin: const EdgeInsets.only(top: 30, right: 20, left: 20),
            child: Column(
              children: [
                Text(
                  textAlign: TextAlign.center,
                  "Fastest Delivery",
                  style: GoogleFonts.poppins(fontSize: 30),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  textAlign: TextAlign.center,
                  "From Our Doorstop to yours, Reliable and Fast delivery.",
                  style: GoogleFonts.poppins(fontSize: 14, height: 1.6),
                ),
              ],
            ),
          ),
        ),
      ],
      next: Container(
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
          child: Text(
            "Next",
            style: GoogleFonts.poppins(color: Colors.white),
          ),
        ),
      ),
      nextFlex: 1,
      done: Container(
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 27.0, vertical: 8),
          child: Text(
            "Done",
            style: GoogleFonts.poppins(color: Colors.white),
          ),
        ),
      ),
      dotsDecorator: const DotsDecorator(activeColor: Colors.black),
      showNextButton: true,
      showDoneButton: true,
      showSkipButton: true,
      skip: Container(
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 27.0, vertical: 8),
          child: Text(
            "Skip",
            style: GoogleFonts.poppins(color: Colors.white),
          ),
        ),
      ),
      onDone: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Login()),
            (Route<dynamic> route) => false);
      },
      onSkip: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Login()),
            (Route<dynamic> route) => false);
      },
    );
  }
}
