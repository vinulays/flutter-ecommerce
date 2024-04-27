import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/screens/AddressForm/address_form.dart';
import 'package:flutter_ecommerce/screens/Profile/bloc/user_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class AddressBottomSheet extends StatefulWidget {
  final Function(String) applyAddressCallback;
  final String initialSelectedAddress;
  const AddressBottomSheet(
      {super.key,
      required this.initialSelectedAddress,
      required this.applyAddressCallback});

  @override
  State<AddressBottomSheet> createState() => _AddressBottomSheetState();
}

class _AddressBottomSheetState extends State<AddressBottomSheet> {
  String? selectedAddress;

  @override
  void initState() {
    super.initState();
    selectedAddress = widget.initialSelectedAddress;
  }

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);
    List<String> addresses = [];

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is AddressesLoaded) {
          addresses = state.addresses;
        }
        return Container(
          decoration: const BoxDecoration(color: Colors.white),
          width: double.infinity,
          child: Container(
            margin:
                EdgeInsets.symmetric(horizontal: deviceData.size.width * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
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
                          "Shipping Address",
                          style: GoogleFonts.poppins(
                              fontSize: 20, fontWeight: FontWeight.w700),
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
                      height: 25,
                    ),
                    Column(
                      children: addresses.map((address) {
                        List<String> parts = address.split('-');
                        String addressText =
                            parts[0].trim(); // Extract the address text
                        String details = parts[1].trim();

                        List<String> detailParts = details.split('#');
                        String personName =
                            detailParts[0].trim(); // Extract the person name
                        String contactNumber = detailParts[1].trim();

                        return Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey.withOpacity(0.1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RadioListTile<String>(
                              subtitle: Text(
                                "$personName, $contactNumber",
                                style: GoogleFonts.poppins(),
                              ),
                              activeColor: Colors.black,
                              title: Container(
                                margin: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  addressText,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              value: address,
                              groupValue: selectedAddress,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedAddress = value;
                                });
                              },
                            ),
                          ),
                        );
                      }).toList(),
                    )
                  ],
                ),
                // * add & select buttons
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {},
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
                                MaterialStateProperty.all<Color>(Colors.white),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.add_outlined,
                                color: Colors.black,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const AddressForm()));
                                },
                                child: Text(
                                  "Add new address",
                                  style: GoogleFonts.poppins(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {
                            widget.applyAddressCallback(selectedAddress!);
                            Navigator.of(context).pop();
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
                            "Select",
                            style: GoogleFonts.poppins(
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
