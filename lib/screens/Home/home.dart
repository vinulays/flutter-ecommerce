import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/screens/Dashboard/dashboard.dart';
import 'package:flutter_ecommerce/screens/ShoppingCart/bloc/shopping_cart_bloc.dart';
import 'package:flutter_ecommerce/screens/ShoppingCart/shopping_cart.dart';
import 'package:flutter_ecommerce/screens/Wishlist/wishlist.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart' as badges;

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
    Wishlist(),
    ShoppingCart(
      fromWhere: "home",
    ),
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
                // child: Image.asset(
                //   "assets/icons/home.png",
                //   height: 24,
                //   width: 24,
                // ),
                child: SvgPicture.asset(
                  "assets/icons/home.svg",
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
                // child: Image.asset(
                //   "assets/icons/heart.png",
                //   height: 24,
                //   width: 24,
                // ),
                child: SvgPicture.asset(
                  "assets/icons/heart.svg",
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
                // child: Image.asset(
                //   "assets/icons/shopping-cart.png",
                //   height: 24,
                //   width: 24,
                // ),
                child: BlocBuilder<ShoppingCartBloc, ShoppingCartState>(
                  builder: (context, state) {
                    if (state is ShoppingCartLoadedState) {
                      return badges.Badge(
                        badgeStyle: const badges.BadgeStyle(
                            shape: badges.BadgeShape.twitter),
                        position: badges.BadgePosition.custom(top: -4, end: -8),
                        showBadge: state.cart.items.isNotEmpty,
                        badgeContent: Container(),
                        child: SvgPicture.asset(
                          "assets/icons/shopping-cart.svg",
                          height: 24,
                          width: 24,
                        ),
                      );
                    } else {
                      return SvgPicture.asset(
                        "assets/icons/shopping-cart.svg",
                        height: 24,
                        width: 24,
                      );
                    }
                  },
                ),
              ),
              activeIcon: Container(
                margin: const EdgeInsets.only(bottom: 5, top: 3),
                // child: Image.asset(
                //   "assets/icons/shopping-cart-black.png",
                //   height: 24,
                //   width: 24,
                // ),
                child: BlocBuilder<ShoppingCartBloc, ShoppingCartState>(
                  builder: (context, state) {
                    if (state is ShoppingCartLoadedState) {
                      return badges.Badge(
                        badgeStyle: const badges.BadgeStyle(
                            shape: badges.BadgeShape.twitter),
                        position: badges.BadgePosition.custom(top: -4, end: -8),
                        showBadge: state.cart.items.isNotEmpty,
                        badgeContent: Container(),
                        child: SvgPicture.asset(
                          "assets/icons/shopping-cart.svg",
                          height: 24,
                          width: 24,
                        ),
                      );
                    } else {
                      return SvgPicture.asset(
                        "assets/icons/shopping-cart.svg",
                        height: 24,
                        width: 24,
                      );
                    }
                  },
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: "Profile",
              icon: Container(
                margin: const EdgeInsets.only(bottom: 5, top: 3),
                // child: Image.asset(
                //   "assets/icons/user.png",
                //   height: 24,
                //   width: 24,
                // ),
                child: SvgPicture.asset(
                  "assets/icons/user.svg",
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
        resizeToAvoidBottomInset: false,
        body: _widgetOptions.elementAt(_selectedIndex));
  }
}
