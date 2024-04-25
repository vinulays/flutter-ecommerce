import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class FormMultiDropDown extends StatelessWidget {
  final String title;
  final bool isRequired;
  final MultiSelectController controller;
  final List<ValueItem> items;
  final List<ValueItem<dynamic>> disabledOptions;

  const FormMultiDropDown(
      {super.key,
      required this.title,
      required this.isRequired,
      required this.controller,
      required this.items,
      required this.disabledOptions});

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
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          MultiSelectDropDown(
            hint: title,
            dropdownBorderRadius: 20,
            suffixIcon: Icon(
              Icons.arrow_drop_down,
              color: Colors.black.withOpacity(0.6),
            ),
            padding:
                const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
            borderRadius: 20,
            hintFontSize: 16,
            optionTextStyle: GoogleFonts.poppins(
              fontSize: 16,
            ),
            hintStyle: GoogleFonts.poppins(
                fontSize: 16,
                // height: 4,
                color: Colors.black.withOpacity(0.40),
                fontWeight: FontWeight.w600),
            controller: controller,
            onOptionSelected: (options) {
              debugPrint(options.toString());
            },
            options: items,
            maxItems: 4,
            disabledOptions: disabledOptions,
            selectionType: SelectionType.multi,
            chipConfig: ChipConfig(
              labelPadding: const EdgeInsets.only(right: 5),
              labelStyle: GoogleFonts.poppins(color: Colors.white),
              padding: const EdgeInsets.only(
                  top: 12, left: 15, bottom: 12, right: 15),
              radius: 20,
              wrapType: WrapType.wrap,
              backgroundColor: Colors.black,
            ),
            dropdownHeight: 300,
            selectedOptionIcon: const Icon(
              Icons.check_circle,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
