import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductsFilterBottomSheet extends StatefulWidget {
  final Function(String, RangeValues) applyFiltersCallBack;
  final String initialAvailabilitySelected;
  final RangeValues initialRangeValues;

  const ProductsFilterBottomSheet(
      {super.key,
      required this.initialAvailabilitySelected,
      required this.initialRangeValues,
      required this.applyFiltersCallBack});

  @override
  State<ProductsFilterBottomSheet> createState() =>
      _ProductsFilterBottomSheetState();
}

class _ProductsFilterBottomSheetState extends State<ProductsFilterBottomSheet> {
  String selectedAvailability = "";
  RangeValues currentRangeValues = const RangeValues(100, 350);

  @override
  void initState() {
    super.initState();
    selectedAvailability = widget.initialAvailabilitySelected;
    currentRangeValues = widget.initialRangeValues;
  }

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

    return Container(
      height: deviceData.size.height * 0.47,
      decoration: const BoxDecoration(color: Colors.white),
      width: double.infinity,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: deviceData.size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
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
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        child: Text(
                          "In Stock",
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.grey.withOpacity(0.5)),
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
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        child: Text(
                          "Out of Stock",
                          style: GoogleFonts.poppins(),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.grey.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(50)),
                      selected: selectedAvailability == "Out of Stock",
                      onSelected: (bool selected) {
                        setState(() {
                          selectedAvailability =
                              (selected ? "Out of Stock" : "");
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
                  height: 35,
                ),
                SliderTheme(
                  data: SliderThemeData(
                      overlayShape: SliderComponentShape.noOverlay,
                      trackHeight: 8,
                      valueIndicatorTextStyle: GoogleFonts.poppins(),
                      showValueIndicator: ShowValueIndicator.always),
                  child: RangeSlider(
                    max: 500,
                    values: currentRangeValues,
                    activeColor: Colors.black,
                    inactiveColor: Colors.grey.withOpacity(0.3),
                    labels: RangeLabels(
                      "\$${currentRangeValues.start.round().toString()}",
                      "\$${currentRangeValues.end.round().toString()}",
                    ),
                    onChanged: (RangeValues values) {
                      setState(() {
                        currentRangeValues = values;
                      });
                    },
                  ),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton.icon(
                          onPressed: () {
                            setState(() {
                              selectedAvailability = "";
                              currentRangeValues = const RangeValues(0, 500);
                            });
                          },
                          icon: const Icon(Icons.close, color: Colors.black),
                          label: Text(
                            "Reset all filters",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton.icon(
                            onPressed: () {
                              widget.applyFiltersCallBack(
                                  selectedAvailability, currentRangeValues);
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.done,
                              color: Colors.white,
                            ),
                            label: Text(
                              "Confirm",
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
