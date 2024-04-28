import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';

class FormTextArea extends StatelessWidget {
  final String title;
  final bool isRequired;
  final String formBuilderName;
  final int maxLines;
  final String? Function(String?)? validators;

  const FormTextArea(
      {super.key,
      required this.title,
      required this.isRequired,
      required this.formBuilderName,
      required this.maxLines,
      this.validators});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: title,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                if (isRequired)
                  TextSpan(
                    text: '*',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFFF0000),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          FormBuilderTextField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.multiline,
            maxLines: 5,
            name: formBuilderName,
            style: GoogleFonts.poppins(),
            decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                errorStyle: GoogleFonts.poppins(
                    fontSize: 14, color: const Color(0xffba000d)),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                // isDense: true,
                prefix: const SizedBox(
                  height: 30,
                  width: 15,
                ),
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
                    height: 0,
                    color: Colors.black.withOpacity(0.40),
                    fontWeight: FontWeight.w600),
                hintText: title),
            validator: validators,
          ),
        ],
      ),
    );
  }
}
