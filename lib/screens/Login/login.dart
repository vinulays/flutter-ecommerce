import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: deviceData.size.width * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Text(
                  "Let's Sign you in.",
                  style: GoogleFonts.poppins(
                      fontSize: 33, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Welcome back",
                  style: GoogleFonts.poppins(
                      fontSize: 28, fontWeight: FontWeight.w400),
                ),
                Text(
                  "You've been missed!",
                  style: GoogleFonts.poppins(
                      fontSize: 28, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 60,
                ),
                TextFormField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 20),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black.withOpacity(0.15)),
                          borderRadius: BorderRadius.circular(20)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black.withOpacity(0.15)),
                          borderRadius: BorderRadius.circular(20)),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black.withOpacity(0.15)),
                          borderRadius: BorderRadius.circular(20)),
                      hintStyle: GoogleFonts.poppins(
                          color: Colors.black.withOpacity(0.40),
                          fontWeight: FontWeight.w600),
                      hintText: "Email or username"),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  cursorColor: Colors.black,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 20),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black.withOpacity(0.15)),
                          borderRadius: BorderRadius.circular(20)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black.withOpacity(0.15)),
                          borderRadius: BorderRadius.circular(20)),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black.withOpacity(0.15)),
                          borderRadius: BorderRadius.circular(20)),
                      hintStyle: GoogleFonts.poppins(
                          color: Colors.black.withOpacity(0.40),
                          fontWeight: FontWeight.w600),
                      hintText: "Password"),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(children: [
                  const Expanded(child: Divider()),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        "Or Sign in With",
                        style: GoogleFonts.poppins(
                            color: Colors.black.withOpacity(0.40)),
                      )),
                  const Expanded(child: Divider()),
                ]),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 0.5, color: Colors.black.withOpacity(0.5)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Center(
                          child: SvgPicture.asset(
                            "assets/icons/google.svg",
                            height: 30,
                            width: 30,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 0.5, color: Colors.black.withOpacity(0.5)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Center(
                          child: SvgPicture.asset(
                            "assets/icons/facebook.svg",
                            height: 30,
                            width: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            // * Sign in button
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: "Don't have an account? ",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.black.withOpacity(0.4))),
                      TextSpan(
                          text: "Register",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: TextButton(
                    onPressed: () {
                      // payment();
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.8),
                        ),
                      ),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(vertical: 17.88)),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                    ),
                    child: Text(
                      "Sign in",
                      style: GoogleFonts.poppins(
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
