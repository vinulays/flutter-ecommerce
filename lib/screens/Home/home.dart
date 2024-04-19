import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/screens/Dashboard/dashboard.dart';

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
        bottomNavigationBar: Container(
          margin: const EdgeInsets.only(bottom: 5),
          child: BottomNavigationBar(
            iconSize: 30,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                label: "Home",
                icon: Image.asset(
                  "assets/icons/home.png",
                  height: 27,
                  width: 27,
                ),
                activeIcon: Image.asset(
                  "assets/icons/home-black.png",
                  height: 27,
                  width: 27,
                ),
              ),
              BottomNavigationBarItem(
                label: "Wishlist",
                icon: Image.asset(
                  "assets/icons/heart.png",
                  height: 27,
                  width: 27,
                ),
                activeIcon: Image.asset(
                  "assets/icons/heart-black.png",
                  height: 27,
                  width: 27,
                ),
              ),
              BottomNavigationBarItem(
                label: "Cart",
                icon: Image.asset(
                  "assets/icons/shopping-cart.png",
                  height: 27,
                  width: 27,
                ),
                activeIcon: Image.asset(
                  "assets/icons/shopping-cart-black.png",
                  height: 27,
                  width: 27,
                ),
              ),
              BottomNavigationBarItem(
                label: "Profile",
                icon: Image.asset(
                  "assets/icons/user.png",
                  height: 27,
                  width: 27,
                ),
                activeIcon: Image.asset(
                  "assets/icons/user-black.png",
                  height: 27,
                  width: 27,
                ),
              ),
            ],
            onTap: _onItemTapped,
            currentIndex: _selectedIndex,
          ),
        ),
        extendBody: true,
        resizeToAvoidBottomInset: false,
        body: _widgetOptions.elementAt(_selectedIndex));
  }
}
