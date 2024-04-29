import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/screens/Dashboard/dashboard.dart';
import 'package:flutter_ecommerce/screens/Profile/profile.dart';
import 'package:flutter_ecommerce/screens/ShoppingCart/bloc/shopping_cart_bloc.dart';
import 'package:flutter_ecommerce/screens/ShoppingCart/shopping_cart.dart';
import 'package:flutter_ecommerce/screens/Wishlist/wishlist.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart' as badges;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    // * Add appropriate screens as commented below
    Dashboard(),
    const Wishlist(),
    const ShoppingCart(
      fromWhere: "home",
    ),
    const Profile(),

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
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              label: "Home",
              icon: Container(
                margin: const EdgeInsets.only(bottom: 3, top: 2),
                child: const Icon(
                  Icons.home_rounded,
                  size: 30,
                ),
              ),
              activeIcon: Container(
                margin: const EdgeInsets.only(bottom: 3, top: 2),
                child: const Icon(
                  Icons.home_rounded,
                  color: Colors.black,
                  size: 30,
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: "Wishlist",
              icon: Container(
                margin: const EdgeInsets.only(bottom: 3, top: 2),
                child: const Icon(
                  Icons.favorite_outline_rounded,
                  size: 30,
                ),
              ),
              activeIcon: Container(
                margin: const EdgeInsets.only(bottom: 3, top: 2),
                child: const Icon(
                  Icons.favorite_rounded,
                  size: 30,
                  color: Colors.black,
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: "Cart",
              icon: Container(
                margin: const EdgeInsets.only(bottom: 3, top: 2),
                child: BlocBuilder<ShoppingCartBloc, ShoppingCartState>(
                  builder: (context, state) {
                    if (state is ShoppingCartLoadedState) {
                      return badges.Badge(
                        badgeStyle: const badges.BadgeStyle(
                            shape: badges.BadgeShape.twitter),
                        position: badges.BadgePosition.custom(top: -4, end: -8),
                        showBadge: state.cart.items.isNotEmpty,
                        badgeContent: Container(),
                        child: const Icon(
                          Icons.shopping_bag_outlined,
                          size: 30,
                        ),
                      );
                    } else {
                      return const Icon(
                        Icons.shopping_bag_outlined,
                        size: 30,
                      );
                    }
                  },
                ),
              ),
              activeIcon: Container(
                margin: const EdgeInsets.only(bottom: 3, top: 2),
                child: BlocBuilder<ShoppingCartBloc, ShoppingCartState>(
                  builder: (context, state) {
                    if (state is ShoppingCartLoadedState) {
                      return badges.Badge(
                        badgeStyle: const badges.BadgeStyle(
                            shape: badges.BadgeShape.twitter),
                        position: badges.BadgePosition.custom(top: -4, end: -8),
                        showBadge: state.cart.items.isNotEmpty,
                        badgeContent: Container(),
                        child: const Icon(
                          Icons.shopping_bag_rounded,
                          size: 30,
                          color: Colors.black,
                        ),
                      );
                    } else {
                      return const Icon(
                        Icons.shopping_bag_rounded,
                        size: 30,
                        color: Colors.black,
                      );
                    }
                  },
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: "Profile",
              icon: Container(
                margin: const EdgeInsets.only(bottom: 3, top: 2),
                child: const Icon(
                  Icons.person_outline_rounded,
                  size: 30,
                ),
              ),
              activeIcon: Container(
                margin: const EdgeInsets.only(bottom: 3, top: 2),
                child: const Icon(Icons.person_rounded,
                    size: 30, color: Colors.black),
              ),
            ),
          ],
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
        ),
        resizeToAvoidBottomInset: false,
        body: _widgetOptions.elementAt(_selectedIndex));
  }
}
