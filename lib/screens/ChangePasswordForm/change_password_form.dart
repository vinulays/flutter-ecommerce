import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/screens/Login/bloc/authentication_bloc.dart';
import 'package:flutter_ecommerce/screens/Login/login.dart';
import 'package:flutter_ecommerce/services/auth_service.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePasswordForm extends StatefulWidget {
  final AuthService authService = AuthService(
      firebaseAuth: FirebaseAuth.instance,
      firestore: FirebaseFirestore.instance);
  ChangePasswordForm({super.key});

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: deviceData.size.width * 0.03),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.chevron_left_outlined,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text("Change Password",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25)),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              FormBuilderTextField(
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: GoogleFonts.poppins(),
                name: "current-password",
                cursorColor: Colors.black,
                decoration: InputDecoration(
                    errorStyle: GoogleFonts.poppins(
                        fontSize: 14, color: const Color(0xffba000d)),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    prefix: Container(
                      width: 20,
                    ),
                    contentPadding: EdgeInsets.zero,
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
                        height: 4,
                        color: Colors.black.withOpacity(0.40),
                        fontWeight: FontWeight.w600),
                    hintText: "Current password"),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: "Current password is required."),
                ]),
              ),
              const SizedBox(
                height: 20,
              ),
              FormBuilderTextField(
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: GoogleFonts.poppins(),
                name: "new-password",
                cursorColor: Colors.black,
                decoration: InputDecoration(
                    errorStyle: GoogleFonts.poppins(
                        fontSize: 14, color: const Color(0xffba000d)),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    prefix: Container(
                      width: 20,
                    ),
                    contentPadding: EdgeInsets.zero,
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
                        height: 4,
                        color: Colors.black.withOpacity(0.40),
                        fontWeight: FontWeight.w600),
                    hintText: "New password"),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: "New password is required."),
                ]),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.saveAndValidate()) {
                        String currentPassword =
                            _formKey.currentState!.value["current-password"];

                        String newPassword =
                            _formKey.currentState!.value["new-password"];

                        context.read<AuthenticationBloc>().add(
                            ChangePasswordEvent(currentPassword, newPassword));

                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()),
                            (Route<dynamic> route) => false);
                      }
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
                      "Confirm",
                      style: GoogleFonts.poppins(
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Note: You will be redirected to the login screen after the password change",
                style:
                    GoogleFonts.poppins(color: Colors.black.withOpacity(0.5)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
