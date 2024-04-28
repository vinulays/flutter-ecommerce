import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminForm extends StatefulWidget {
  const AdminForm({super.key});

  @override
  State<AdminForm> createState() => _AdminFormState();
}

class _AdminFormState extends State<AdminForm> {
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
                  Text("Add admin account",
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
              Expanded(
                  child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  FormBuilderTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: GoogleFonts.poppins(),
                    name: "username",
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
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
                        hintText: "Username"),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: "Username is required."),
                      FormBuilderValidators.minLength(4,
                          errorText: "Username should have at least 4 letters"),
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FormBuilderTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: GoogleFonts.poppins(),
                    name: "displayName",
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
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
                        hintText: "Display Name"),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: "Display Name is required."),
                      FormBuilderValidators.minLength(4,
                          errorText:
                              "Display Name should have at least 4 letters"),
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FormBuilderTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: GoogleFonts.poppins(),
                    name: "mobile",
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
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
                        hintText: "Mobile number"),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: "Mobile number is required."),
                      FormBuilderValidators.equalLength(10,
                          errorText: "Mobile number should have 10 letters"),
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FormBuilderTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: GoogleFonts.poppins(),
                    name: "email",
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
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
                          errorText: "Email address is required."),
                      FormBuilderValidators.email(
                          errorText: "Invalid email address"),
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FormBuilderTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: GoogleFonts.poppins(),
                    name: "password",
                    obscureText: true,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
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
                        hintText: "Password"),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: "Password is required."),
                      FormBuilderValidators.minLength(4,
                          errorText: "Password should have at least 6 letters"),
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
                        onPressed: () async {
                          if (_formKey.currentState!.saveAndValidate()) {
                            final values = _formKey.currentState!.value;

                            final username = values['username'] as String;
                            final displayName = values['displayName'] as String;
                            final mobileNumber = values['mobile'] as String;
                            final emailAddress = values['email'] as String;
                            final password = values['password'] as String;

                            try {
                              UserCredential userCredential = await FirebaseAuth
                                  .instance
                                  .createUserWithEmailAndPassword(
                                email: emailAddress,
                                password: password,
                              );

                              String userId = userCredential.user!.uid;

                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(userId)
                                  .set({
                                'username': username,
                                'displayName': displayName,
                                'mobileNumber': mobileNumber,
                                "avatarURL": "",
                                "addresses": [],
                                "role": "admin",
                                "likedProducts": [],
                                "contactNo": mobileNumber
                              });

                              if (context.mounted) {
                                Navigator.of(context).pop();
                              }
                            } catch (e) {
                              throw Exception("Failed to add admin: $e");
                            }
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
                        child: Text(
                          "Save",
                          style: GoogleFonts.poppins(
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
