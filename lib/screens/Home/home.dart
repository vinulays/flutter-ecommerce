import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/screens/Dashboard/dashboard.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    // * Add appropriate screens as commented below
    Dashboard(),
    Dashboard(),
    Dashboard(),
    Dashboard(),

    // * Notifications
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: GoogleFonts.poppins(),
          unselectedLabelStyle: GoogleFonts.poppins(),
          selectedFontSize: 12,
          // showSelectedLabels: false,
          // showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              label: "Home",
              icon: Container(
                margin: const EdgeInsets.only(bottom: 5, top: 3),
                child: Image.asset(
                  "assets/icons/home.png",
                  height: 24,
                  width: 24,
                ),
              ),
              activeIcon: Container(
                margin: const EdgeInsets.only(bottom: 5, top: 3),
                child: Image.asset(
                  "assets/icons/home-black.png",
                  height: 24,
                  width: 24,
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: "Wishlist",
              icon: Container(
                margin: const EdgeInsets.only(bottom: 5, top: 3),
                child: Image.asset(
                  "assets/icons/heart.png",
                  height: 24,
                  width: 24,
                ),
              ),
              activeIcon: Container(
                margin: const EdgeInsets.only(bottom: 5, top: 3),
                child: Image.asset(
                  "assets/icons/heart-black.png",
                  height: 24,
                  width: 24,
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: "Cart",
              icon: Container(
                margin: const EdgeInsets.only(bottom: 5, top: 3),
                child: Image.asset(
                  "assets/icons/shopping-cart-black.png",
                  height: 24,
                  width: 24,
                ),
              ),
              activeIcon: Container(
                margin: const EdgeInsets.only(bottom: 5, top: 3),
                child: Image.asset(
                  "assets/icons/shopping-cart-black.png",
                  height: 24,
                  width: 24,
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: "Profile",
              icon: Container(
                margin: const EdgeInsets.only(bottom: 5, top: 3),
                child: Image.asset(
                  "assets/icons/user.png",
                  height: 24,
                  width: 24,
                ),
              ),
              activeIcon: Container(
                margin: const EdgeInsets.only(bottom: 5, top: 3),
                child: Image.asset(
                  "assets/icons/user-black.png",
                  height: 24,
                  width: 24,
                ),
              ),
            ),
          ],
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
        ),
        extendBody: true,
        resizeToAvoidBottomInset: false,
        body: _widgetOptions.elementAt(_selectedIndex));
  }
}
