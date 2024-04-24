import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/screens/Home/home.dart';
import 'package:flutter_ecommerce/screens/Login/bloc/authentication_bloc.dart';
import 'package:flutter_ecommerce/screens/Signup/signup.dart';
import 'package:flutter_ecommerce/screens/Wishlist/bloc/wishlist_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormBuilderState>();
  String? errorMsg;

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

    return BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationAuthenticated) {
            context.read<WishlistBloc>().add(FetchWishListEvent());

            // * navigatin to home page after a successfull login
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const Home()));
          } else if (state is AuthenticationUnauthenticated) {
            // * set error message under the email field
            setState(() {
              errorMsg = "Invalid Email address or Password";
            });
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            margin:
                EdgeInsets.symmetric(horizontal: deviceData.size.width * 0.05),
            child: FormBuilder(
              key: _formKey,
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
                      FormBuilderTextField(
                        onTap: () {
                          setState(() {
                            errorMsg = null;
                          });
                        },
                        style: GoogleFonts.poppins(),
                        name: "email",
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                            errorText: errorMsg,
                            errorStyle: GoogleFonts.poppins(
                                fontSize: 14, color: const Color(0xffba000d)),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            // isDense: true,
                            prefix: Container(
                              width: 20,
                            ),
                            contentPadding: EdgeInsets.zero,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black.withOpacity(0.15)),
                                borderRadius: BorderRadius.circular(20)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black.withOpacity(0.15)),
                                borderRadius: BorderRadius.circular(20)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black.withOpacity(0.15)),
                                borderRadius: BorderRadius.circular(20)),
                            hintStyle: GoogleFonts.poppins(
                                height: 4,
                                color: Colors.black.withOpacity(0.40),
                                fontWeight: FontWeight.w600),
                            hintText: "Email address"),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: "Email is required."),
                          FormBuilderValidators.email(
                              errorText: "Invalid email address.")
                        ]),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FormBuilderTextField(
                        style: GoogleFonts.poppins(),
                        name: "password",
                        cursorColor: Colors.black,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                            errorStyle: GoogleFonts.poppins(
                                fontSize: 14, color: const Color(0xffba000d)),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            contentPadding: EdgeInsets.zero,
                            prefix: Container(
                              width: 20,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black.withOpacity(0.15)),
                                borderRadius: BorderRadius.circular(20)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black.withOpacity(0.15)),
                                borderRadius: BorderRadius.circular(20)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black.withOpacity(0.15)),
                                borderRadius: BorderRadius.circular(20)),
                            hintStyle: GoogleFonts.poppins(
                                height: 4,
                                color: Colors.black.withOpacity(0.40),
                                fontWeight: FontWeight.w600),
                            hintText: "Password"),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: "Password is required."),
                        ]),
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
                                  width: 0.5,
                                  color: Colors.black.withOpacity(0.5)),
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
                                  width: 0.5,
                                  color: Colors.black.withOpacity(0.5)),
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
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => const Signup()));
                                },
                              text: "Register",
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
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
                            setState(() {
                              errorMsg = null;
                            });

                            if (_formKey.currentState!.saveAndValidate()) {
                              final values = _formKey.currentState!.value;
                              final email = values['email'] as String;
                              final password = values['password'] as String;

                              _formKey.currentState!.reset();

                              context.read<AuthenticationBloc>().add(
                                  UserLoginRequested(
                                      email: email, password: password));
                            }
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.8),
                              ),
                            ),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(vertical: 17.88)),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                          ),
                          child: BlocBuilder<AuthenticationBloc,
                              AuthenticationState>(
                            builder: (context, state) {
                              if (state is AuthenticationLoading ||
                                  state is AuthenticationAuthenticated) {
                                return const SizedBox(
                                  height: 27,
                                  width: 27,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                );
                              }
                              return Text(
                                "Sign in",
                                style: GoogleFonts.poppins(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
