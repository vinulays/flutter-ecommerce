import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/screens/CategoryDetails/bloc/category_details_bloc.dart';
import 'package:flutter_ecommerce/ui/product_card.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryDetails extends StatefulWidget {
  final String categoryName;
  final String bannerURL;

  const CategoryDetails(
      {super.key, required this.categoryName, required this.bannerURL});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  String? selectedValue = "All items";

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;

    final List<String> items = [
      "All items",
      'New Arrival',
      'Price: High to Low',
      'Price: Low to High',
    ];

    List<Product> products = [];

    return BlocBuilder<CategoryDetailsBloc, CategoryDetailsState>(
      builder: (context, state) {
        if (state is CategoryLoaded) {
          products = state.products;
        }

        return Scaffold(
          body: (state is CategoryLoaded)
              ? Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              height: deviceSize.height * 0.33,
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(widget.bannerURL),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            Positioned.fill(
                                child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 55),
                                      child: Text(
                                        widget.categoryName,
                                        style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 45,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )))
                          ],
                        ),
                        // * no of products & sort button
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: deviceSize.width * 0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${products.length.toString()} items",
                                style: GoogleFonts.poppins(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                              DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  items: items
                                      .map(
                                        (String item) =>
                                            DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: GoogleFonts.poppins(),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  value: selectedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValue = value;
                                    });
                                  },
                                  buttonStyleData: ButtonStyleData(
                                    height: 40,
                                    width: 190,
                                    padding: const EdgeInsets.only(
                                        left: 14, right: 14),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Colors.black26,
                                      ),
                                    ),
                                  ),
                                  iconStyleData: const IconStyleData(
                                    icon: Icon(
                                      CupertinoIcons.chevron_down,
                                    ),
                                    iconSize: 14,
                                    iconEnabledColor: Colors.black,
                                    iconDisabledColor: Colors.grey,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    maxHeight: 200,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    offset: const Offset(-20, 0),
                                    scrollbarTheme: ScrollbarThemeData(
                                      radius: const Radius.circular(40),
                                      thickness: MaterialStateProperty.all(6),
                                      thumbVisibility:
                                          MaterialStateProperty.all(true),
                                    ),
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 40,
                                    padding:
                                        EdgeInsets.only(left: 14, right: 14),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // * category items
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: deviceSize.width * 0.05),
                          child: Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            runSpacing: 10,
                            children:
                                List.generate(state.products.length, (index) {
                              return ProductCard(
                                  product: state.products[index]);
                            }),
                          ),
                        )
                      ],
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              margin: const EdgeInsets.only(top: 50, left: 25),
                              decoration: const BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle),
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Icon(
                                    Icons.chevron_left,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                            // * back and like button
                            Container(
                                height: 40,
                                width: 40,
                                margin:
                                    const EdgeInsets.only(top: 50, right: 25),
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                child: const Center(
                                  child: Icon(Icons.search),
                                )),
                          ],
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: const EdgeInsets.all(30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
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
                                      onPressed: () {},
                                      icon: const Icon(
                                          Icons.filter_alt_outlined,
                                          color: Colors.black),
                                      label: Text(
                                        "Add Filter",
                                        style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
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
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.shopping_cart_outlined,
                                        color: Colors.white,
                                      ),
                                      label: Text(
                                        "Cart Empty",
                                        style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
              : (state is CategoryLoading)
                  ? const Center(
                      child: CircularProgressIndicator(
                        strokeCap: StrokeCap.round,
                        strokeWidth: 5,
                        color: Color(0xff75A488),
                      ),
                    )
                  : Container(),
        );
      },
    );
  }
}
