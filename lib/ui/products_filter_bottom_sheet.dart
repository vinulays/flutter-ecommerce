import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class ProductsFilterBottomSheet extends StatefulWidget {
  const ProductsFilterBottomSheet({super.key});

  @override
  State<ProductsFilterBottomSheet> createState() =>
      _ProductsFilterBottomSheetState();
}

class _ProductsFilterBottomSheetState extends State<ProductsFilterBottomSheet> {
  String selectedAvailability = "";
  SfRangeValues priceRange = const SfRangeValues(0, 30);

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: deviceData.size.width * 0.05),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 20),
                ),
                Text(
                  "Filters",
                  style: GoogleFonts.poppins(
                      fontSize: 25, fontWeight: FontWeight.w700),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.withOpacity(0.2)),
                      child: const Icon(Icons.close)),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Availability",
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
            ),
            Wrap(
              spacing: 10,
              children: [
                ChoiceChip(
                  selectedColor: Colors.black,
                  showCheckmark: false,
                  labelStyle: GoogleFonts.poppins(
                      color: selectedAvailability == "In Stock"
                          ? Colors.white
                          : Colors.black),
                  label: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: Text(
                      "In Stock",
                      style: GoogleFonts.poppins(),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey.withOpacity(0.2)),
                      borderRadius: BorderRadius.circular(50)),
                  selected: selectedAvailability == "In Stock",
                  onSelected: (bool selected) {
                    setState(() {
                      selectedAvailability = (selected ? "In Stock" : "");
                    });
                  },
                ),
                ChoiceChip(
                  showCheckmark: false,
                  selectedColor: Colors.black,
                  labelStyle: GoogleFonts.poppins(
                      color: selectedAvailability == "Out of Stock"
                          ? Colors.white
                          : Colors.black),
                  label: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: Text(
                      "Out of Stock",
                      style: GoogleFonts.poppins(),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey.withOpacity(0.2)),
                      borderRadius: BorderRadius.circular(50)),
                  selected: selectedAvailability == "Out of Stock",
                  onSelected: (bool selected) {
                    setState(() {
                      selectedAvailability = (selected ? "Out of Stock" : "");
                    });
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Price Range",
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 60,
            ),
            SfRangeSlider(
                tooltipTextFormatterCallback:
                    (dynamic actualValue, String formattedText) {
                  return "\$${actualValue.toStringAsFixed(0)}";
                },
                tooltipShape: const SfPaddleTooltipShape(),
                shouldAlwaysShowTooltip: true,
                activeColor: Colors.black,
                inactiveColor: Colors.grey.withOpacity(0.3),
                min: 0.0,
                max: 500,
                showTicks: true,
                enableTooltip: true,
                values: priceRange,
                onChanged: (SfRangeValues values) {
                  setState(() {
                    priceRange = values;
                  });
                })
          ],
        ),
      ),
    );
  }
}
