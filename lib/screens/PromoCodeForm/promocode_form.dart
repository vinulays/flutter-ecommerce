import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/promo_code.dart';
import 'package:flutter_ecommerce/services/promocode_service.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';

class PromoCodeForm extends StatefulWidget {
  final PromoCodeService promoCodeService = PromoCodeService();

  PromoCodeForm({super.key});

  @override
  State<PromoCodeForm> createState() => _PromoCodeFormState();
}

class _PromoCodeFormState extends State<PromoCodeForm> {
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
                  Text("Add new promo code",
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
                    name: "codeName",
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
                        hintText: "Code Name"),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.minLength(4,
                          errorText:
                              "Code Name should have at least 4 letters"),
                      FormBuilderValidators.required(
                          errorText: "Code Name is required."),
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FormBuilderTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: GoogleFonts.poppins(),
                    name: "discount",
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        errorStyle: GoogleFonts.poppins(
                            fontSize: 14, color: const Color(0xffba000d)),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        // isDense: true,
                        prefix: Container(
                          width: 20,
                        ),
                        suffixIcon: Icon(
                          Icons.percent,
                          color: Colors.black.withOpacity(0.6),
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
                        hintText: "Discount"),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.max(30,
                          errorText: "Maximum discount is 30%"),
                      FormBuilderValidators.required(
                          errorText: "Discount is required."),
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
                            String codeName =
                                _formKey.currentState!.value['codeName'];
                            String discount =
                                _formKey.currentState!.value["discount"];

                            PromoCode promoCode = PromoCode(
                                codeName: codeName,
                                discount: double.parse(discount) / 100,
                                usedUserIds: []);
                            await widget.promoCodeService
                                .addPromoCode(promoCode);

                            if (context.mounted) {
                              Navigator.of(context).pop();
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
