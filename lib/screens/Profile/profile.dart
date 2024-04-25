import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/models/user.dart';
import 'package:flutter_ecommerce/screens/Login/bloc/authentication_bloc.dart';
import 'package:flutter_ecommerce/screens/ShoppingCart/shopping_cart.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String getAvatarLetters(String name) {
    List<String> words = name.split(" ");
    String firstLetters = "";

    for (var word in words) {
      if (word.isNotEmpty) {
        firstLetters += word[0];
      }
    }

    return firstLetters;
  }

  @override
  Widget build(BuildContext context) {
    UserLocal? userLocal;
    var deviceData = MediaQuery.of(context);

    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationAuthenticated) {
          userLocal = state.user;
        }

        return Scaffold(
          body: Container(
            margin:
                EdgeInsets.symmetric(horizontal: deviceData.size.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Text(
                  "My Profile",
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                const SizedBox(
                  height: 30,
                ),
                // * profile header
                Row(
                  children: [
                    if (userLocal?.avatarURL != null &&
                        userLocal?.avatarURL != "")
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(userLocal!.avatarURL!),
                      ),
                    if (userLocal?.avatarURL == null ||
                        userLocal?.avatarURL == "")
                      CircleAvatar(
                        backgroundColor: Colors.black.withOpacity(0.1),
                        radius: 50,
                        child: Text(
                          getAvatarLetters(userLocal!.displayName),
                          style: GoogleFonts.poppins(fontSize: 35),
                        ),
                      ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userLocal!.displayName,
                          style: GoogleFonts.poppins(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          userLocal!.email,
                          style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: Colors.black.withOpacity(0.5)),
                        ),
                      ],
                    )
                  ],
                ),
                Expanded(
                    child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    const SizedBox(
                      height: 35,
                    ),
                    // * Shop settings
                    Row(
                      children: [
                        const Icon(
                          Icons.store_outlined,
                          size: 28,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Store Settings",
                          style: GoogleFonts.poppins(fontSize: 16),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Divider(
                      color: Colors.black.withOpacity(0.1),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "My Orders",
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.black.withOpacity(0.6)),
                        ),
                        Icon(Icons.chevron_right_rounded,
                            size: 30, color: Colors.black.withOpacity(0.6))
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ShoppingCart(
                              fromWhere: "profile",
                            ),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Shopping Cart",
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.black.withOpacity(0.6)),
                          ),
                          Icon(Icons.chevron_right_rounded,
                              size: 30, color: Colors.black.withOpacity(0.6))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "My Address",
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.black.withOpacity(0.6)),
                        ),
                        Icon(Icons.chevron_right_rounded,
                            size: 30, color: Colors.black.withOpacity(0.6))
                      ],
                    ),
                    if (userLocal!.role == "admin")
                      const SizedBox(
                        height: 15,
                      ),
                    if (userLocal!.role == "admin")
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Add a product",
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.black.withOpacity(0.6)),
                          ),
                          Icon(Icons.chevron_right_rounded,
                              size: 30, color: Colors.black.withOpacity(0.6))
                        ],
                      ),

                    const SizedBox(
                      height: 25,
                    ),
                    // * Account settings
                    Row(
                      children: [
                        const Icon(
                          Icons.person_outline_outlined,
                          size: 28,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Account Settings",
                          style: GoogleFonts.poppins(fontSize: 16),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Divider(
                      color: Colors.black.withOpacity(0.1),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Username",
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.black.withOpacity(0.6)),
                        ),
                        Icon(Icons.chevron_right_rounded,
                            size: 30, color: Colors.black.withOpacity(0.6))
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Phone number",
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.black.withOpacity(0.6)),
                        ),
                        Icon(Icons.chevron_right_rounded,
                            size: 30, color: Colors.black.withOpacity(0.6))
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Password",
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.black.withOpacity(0.6)),
                        ),
                        Icon(Icons.chevron_right_rounded,
                            size: 30, color: Colors.black.withOpacity(0.6))
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Deactivate Account",
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.black.withOpacity(0.6)),
                        ),
                        Icon(Icons.chevron_right_rounded,
                            size: 30, color: Colors.black.withOpacity(0.6))
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Log out",
                          style: GoogleFonts.poppins(
                              fontSize: 16, color: Colors.red),
                        ),
                        Icon(Icons.chevron_right_rounded,
                            size: 30, color: Colors.red.withOpacity(0.7))
                      ],
                    ),
                  ],
                )),
              ],
            ),
          ),
        );
      },
    );
  }
}
