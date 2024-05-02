import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/models/user.dart';
import 'package:flutter_ecommerce/screens/AdminForm/admin_form.dart';
import 'package:flutter_ecommerce/screens/ChangePasswordForm/change_password_form.dart';
import 'package:flutter_ecommerce/screens/ChangeSettingsForm/change_settings_form.dart';
import 'package:flutter_ecommerce/screens/FlashSales/bloc/flashsale_bloc.dart';
import 'package:flutter_ecommerce/screens/FlashSales/flashsale_details.dart';
import 'package:flutter_ecommerce/screens/Login/bloc/authentication_bloc.dart';
import 'package:flutter_ecommerce/screens/Login/login.dart';
import 'package:flutter_ecommerce/screens/Orders/bloc/orders_bloc.dart';
import 'package:flutter_ecommerce/screens/Orders/orders.dart';
import 'package:flutter_ecommerce/screens/ProductForm/product_form.dart';
import 'package:flutter_ecommerce/screens/PromoCodeForm/promocode_form.dart';
import 'package:flutter_ecommerce/screens/ShoppingCart/shopping_cart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final ImagePicker _picker = ImagePicker();
  File? _avatarImage;

  // * use to get first letter of the each word in user's display name.
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

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _avatarImage = File(pickedFile.path);
      });
    }
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
                    // * if user has a image display it. Otherwise, display letters.
                    if (userLocal?.avatarURL != null &&
                        userLocal?.avatarURL != "")
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          CachedNetworkImage(
                            imageUrl: userLocal!.avatarURL!,
                            imageBuilder: (context, imageProvider) => Container(
                              height: 110,
                              width: 110,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                                shape: BoxShape.circle,
                              ),
                            ),
                            placeholder: (context, url) => const SizedBox(
                              height: 110,
                              width: 110,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [CircularProgressIndicator()],
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                          Positioned(
                            bottom: -3,
                            right: 0,
                            child: GestureDetector(
                              onTap: () async {
                                await pickImage();

                                if (context.mounted) {
                                  if (_avatarImage != null) {
                                    context.read<AuthenticationBloc>().add(
                                        UpdateAvatarEvent(
                                            _avatarImage!, userLocal!.id!));

                                    setState(() {
                                      _avatarImage = null;
                                    });
                                  }
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black.withOpacity(0.1)),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    if (userLocal?.avatarURL == null ||
                        userLocal?.avatarURL == "")
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.black.withOpacity(0.1),
                            radius: 50,
                            child: Text(
                              getAvatarLetters(userLocal!.displayName),
                              style: GoogleFonts.poppins(fontSize: 35),
                            ),
                          ),
                          Positioned(
                            bottom: -3,
                            right: 0,
                            child: GestureDetector(
                              onTap: () async {
                                await pickImage();

                                if (context.mounted) {
                                  if (_avatarImage != null) {
                                    context.read<AuthenticationBloc>().add(
                                        UpdateAvatarEvent(
                                            _avatarImage!, userLocal!.id!));

                                    setState(() {
                                      _avatarImage = null;
                                    });
                                  }
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black.withOpacity(0.1)),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    const SizedBox(
                      width: 15,
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
                        SizedBox(
                          width: 220,
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            userLocal!.email!,
                            style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: Colors.black.withOpacity(0.5)),
                          ),
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
                    // * If the user is an admin, display all orders. Otherwise, display my orders.
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        if (userLocal!.role != "admin") {
                          context.read<OrdersBloc>().add(FetchOrdersEvent());
                        } else {
                          context.read<OrdersBloc>().add(FetchAllOrdersEvent());
                        }

                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Orders()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            (userLocal!.role == "admin")
                                ? "All Orders"
                                : "My Orders",
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.black.withOpacity(0.6)),
                          ),
                          Icon(Icons.chevron_right_rounded,
                              size: 30, color: Colors.black.withOpacity(0.6))
                        ],
                      ),
                    ),
                    if (userLocal!.role == "user")
                      const SizedBox(
                        height: 15,
                      ),
                    // * shopping cart
                    if (userLocal!.role == "user")
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
                    if (userLocal!.role == "admin")
                      const SizedBox(
                        height: 15,
                      ),
                    // * if the user is an admin, display add a new product button.
                    if (userLocal!.role == "admin")
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const ProductForm(
                                isUpdate: false,
                              ),
                            ),
                          );
                        },
                        child: Row(
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
                      ),
                    if (userLocal!.role == "admin")
                      const SizedBox(
                        height: 15,
                      ),
                    // * if the user is an admin, disolay manage flash sales button.
                    if (userLocal!.role == "admin")
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          context
                              .read<FlashsaleBloc>()
                              .add(FetchFlashSaleEvent());

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => FlashSaleDetails(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Manage flash sales",
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                            Icon(Icons.chevron_right_rounded,
                                size: 30, color: Colors.black.withOpacity(0.6))
                          ],
                        ),
                      ),
                    if (userLocal!.role == "admin")
                      const SizedBox(
                        height: 15,
                      ),
                    // * if the user is an admin, disolay add a promo code button.
                    if (userLocal!.role == "admin")
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PromoCodeForm(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Add a promo code",
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                            Icon(Icons.chevron_right_rounded,
                                size: 30, color: Colors.black.withOpacity(0.6))
                          ],
                        ),
                      ),
                    if (userLocal!.role == "admin")
                      const SizedBox(
                        height: 15,
                      ),
                    // * if the user is an admin, disolay add an admin button.
                    if (userLocal!.role == "admin")
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const AdminForm(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Add an admin",
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
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ChangeSettingsForm(
                              userId: userLocal!.id!,
                              settingValue: userLocal!.displayName,
                              settingName: "Username",
                            ),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Change Display name",
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
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ChangeSettingsForm(
                              userId: userLocal!.id!,
                              settingValue: userLocal!.contactNo ?? "",
                              settingName: "Phone number",
                            ),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Change Mobile number",
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.black.withOpacity(0.6)),
                          ),
                          Icon(Icons.chevron_right_rounded,
                              size: 30, color: Colors.black.withOpacity(0.6))
                        ],
                      ),
                    ),
                    if (FirebaseAuth
                            .instance.currentUser!.providerData[0].providerId ==
                        "password")
                      const SizedBox(
                        height: 15,
                      ),
                    if (FirebaseAuth
                            .instance.currentUser!.providerData[0].providerId ==
                        "password")
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ChangePasswordForm(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Change Password",
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

                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        context
                            .read<AuthenticationBloc>()
                            .add(LogoutRequested(context));

                        // * going back to login page after sign out.
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()),
                            (Route<dynamic> route) => false);
                      },
                      child: Row(
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
