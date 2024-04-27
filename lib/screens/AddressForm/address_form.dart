import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/screens/Profile/bloc/user_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';

class AddressForm extends StatefulWidget {
  const AddressForm({super.key});

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  Text("Add new address",
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
                      name: "name",
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
                          hintText: "Recipient Name"),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.minLength(5,
                            errorText:
                                "Recipient Name should large than 5 letters."),
                        FormBuilderValidators.required(
                            errorText: "Recipient Name is required."),
                      ]),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FormBuilderTextField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: GoogleFonts.poppins(),
                      name: "phone",
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
                          hintText: "Phone number"),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.minLength(5,
                            errorText:
                                "Phone number should large than 5 letters."),
                        FormBuilderValidators.required(
                            errorText: "Phone number is required."),
                      ]),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: FormBuilderTextField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: GoogleFonts.poppins(),
                            name: "street",
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
                                hintText: "Street"),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText: "Street is required."),
                            ]),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          flex: 1,
                          child: FormBuilderTextField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: GoogleFonts.poppins(),
                            name: "postalcode",
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
                                hintText: "Postal Code"),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText: "Postal Code is required."),
                            ]),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: FormBuilderTextField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: GoogleFonts.poppins(),
                            name: "city",
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
                                hintText: "City"),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText: "City is required."),
                            ]),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          flex: 1,
                          child: FormBuilderTextField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: GoogleFonts.poppins(),
                            name: "state",
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
                                hintText: "State"),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText: "State is required."),
                            ]),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FormBuilderTextField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: GoogleFonts.poppins(),
                      name: "country",
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
                          hintText: "Country"),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: "Country is required."),
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
                              String recipientName =
                                  _formKey.currentState!.value['name'];
                              String phoneNumber =
                                  _formKey.currentState!.value['phone'];

                              String street =
                                  _formKey.currentState!.value['street'];
                              String postalCode =
                                  _formKey.currentState!.value['postalcode'];

                              String city =
                                  _formKey.currentState!.value['city'];
                              String state =
                                  _formKey.currentState!.value['state'];
                              String country =
                                  _formKey.currentState!.value['country'];

                              String address =
                                  '$street, $city, $state, $country, $postalCode';
                              String details = '-$recipientName #$phoneNumber';

                              String formattedAddress = '$address $details';

                              context
                                  .read<UserBloc>()
                                  .add(AddAddress(formattedAddress));

                              Navigator.of(context).pop();
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
