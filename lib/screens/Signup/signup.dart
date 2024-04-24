import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/screens/Login/bloc/authentication_bloc.dart';
import 'package:flutter_ecommerce/screens/Login/login.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const Login()));
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.chevron_left_rounded,
                    size: 30,
                  ),
                ),
                const SizedBox(
                  height: 23,
                ),
                Text(
                  "Let's create your account.",
                  style: GoogleFonts.poppins(
                      fontSize: 27, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 25,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      // * firstname and lastname
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: FormBuilderTextField(
                                  autovalidateMode: AutovalidateMode.always,
                                  style: GoogleFonts.poppins(),
                                  name: "firstname",
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                      errorStyle: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: const Color(0xffba000d)),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      // isDense: true,
                                      prefix: Container(
                                        width: 20,
                                      ),
                                      contentPadding: EdgeInsets.zero,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black
                                                  .withOpacity(0.15)),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black
                                                  .withOpacity(0.15)),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black
                                                  .withOpacity(0.15)),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      hintStyle: GoogleFonts.poppins(
                                          height: 4,
                                          color: Colors.black.withOpacity(0.40),
                                          fontWeight: FontWeight.w600),
                                      hintText: "First Name"),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                        errorText: "First Name is required."),
                                  ]),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                flex: 1,
                                child: FormBuilderTextField(
                                  autovalidateMode: AutovalidateMode.always,
                                  style: GoogleFonts.poppins(),
                                  name: "lastname",
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                      errorStyle: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: const Color(0xffba000d)),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      // isDense: true,
                                      prefix: Container(
                                        width: 20,
                                      ),
                                      contentPadding: EdgeInsets.zero,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black
                                                  .withOpacity(0.15)),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black
                                                  .withOpacity(0.15)),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black
                                                  .withOpacity(0.15)),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      hintStyle: GoogleFonts.poppins(
                                          height: 4,
                                          color: Colors.black.withOpacity(0.40),
                                          fontWeight: FontWeight.w600),
                                      hintText: "Last Name"),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                        errorText: "Last Name is required."),
                                  ]),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          FormBuilderTextField(
                            autovalidateMode: AutovalidateMode.always,
                            style: GoogleFonts.poppins(),
                            name: "username",
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                                errorStyle: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: const Color(0xffba000d)),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
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
                                hintText: "User Name"),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.minLength(5,
                                  errorText:
                                      "Username should large than 5 letters."),
                              FormBuilderValidators.required(
                                  errorText: "User Name is required."),
                            ]),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          FormBuilderTextField(
                            autovalidateMode: AutovalidateMode.always,
                            style: GoogleFonts.poppins(),
                            name: "email",
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                                errorStyle: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: const Color(0xffba000d)),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
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
                                hintText: "Email Address"),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText: "Email Name is required."),
                              FormBuilderValidators.email(
                                  errorText: "Invalid email address.")
                            ]),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          FormBuilderTextField(
                            autovalidateMode: AutovalidateMode.always,
                            style: GoogleFonts.poppins(),
                            name: "phone",
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                                errorStyle: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: const Color(0xffba000d)),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
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
                                hintText: "Phone Number"),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText: "Phone number is required."),
                            ]),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          FormBuilderTextField(
                            autovalidateMode: AutovalidateMode.always,
                            style: GoogleFonts.poppins(),
                            name: "password",
                            cursorColor: Colors.black,
                            obscureText: true,
                            decoration: InputDecoration(
                                errorStyle: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: const Color(0xffba000d)),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
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
                                hintText: "Password"),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText: "Password is required."),
                            ]),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // * sign up button
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(children: [
                      const Expanded(child: Divider()),
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "Or Sign up With",
                            style: GoogleFonts.poppins(
                                color: Colors.black.withOpacity(0.40)),
                          )),
                      const Expanded(child: Divider()),
                    ]),
                    const SizedBox(
                      height: 20,
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
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: "Already have an account? ",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: Colors.black.withOpacity(0.4))),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const Login()));
                              },
                            text: "Login",
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
                          if (_formKey.currentState!.saveAndValidate()) {
                            final values = _formKey.currentState!.value;
                            final firstname = values['firstname'] as String;
                            final lastname = values['lastname'] as String;
                            final username = values['username'] as String;
                            final mobileNumber = values['phone'] as String;
                            final displayName = "$firstname $lastname";
                            String role = "user";

                            final email = values['email'] as String;
                            final password = values['password'] as String;

                            _formKey.currentState!.reset();

                            context.read<AuthenticationBloc>().add(
                                SignUpRequested(
                                    displayName: displayName,
                                    username: username,
                                    email: email,
                                    mobileNumber: mobileNumber,
                                    password: password,
                                    role: role));
                          }
                        },
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
                            if (state is SignUpInProgress ||
                                state is SignUpSuccess) {
                              return const SizedBox(
                                height: 27,
                                width: 27,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              );
                            }
                            return Text(
                              "Sign up",
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
      ),
    );
  }
}
