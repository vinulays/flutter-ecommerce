import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/ui/form_drop_down.dart';
import 'package:flutter_ecommerce/ui/form_input_field.dart';
import 'package:flutter_ecommerce/ui/form_multi_drop_down.dart';
import 'package:flutter_ecommerce/ui/form_text_area.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class ProductForm extends StatefulWidget {
  final bool isUpdate;
  const ProductForm({super.key, required this.isUpdate});

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  final MultiSelectController _sizeController = MultiSelectController();
  final MultiSelectController _colorController = MultiSelectController();

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: deviceData.size.width * 0.05),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  Text(
                      "${widget.isUpdate == true ? "Update" : "Add a"} Product",
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
                  // * product title
                  FormInputField(
                    title: "Title",
                    isRequired: true,
                    formBuilderName: "title",
                    validators: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: "Title is required"),
                      FormBuilderValidators.minLength(10,
                          errorText: "Title should be longer than 10 letters"),
                    ]),
                  ),

                  // * product description
                  FormTextArea(
                    title: "Description",
                    isRequired: true,
                    formBuilderName: "description",
                    maxLines: 5,
                    validators: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: "Description is required"),
                      FormBuilderValidators.minLength(10,
                          errorText:
                              "Description should be longer than 10 letters"),
                    ]),
                  ),
                  // * product price
                  FormInputField(
                    title: "Price",
                    isRequired: true,
                    formBuilderName: "price",
                    validators: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: "Price is required"),
                      FormBuilderValidators.numeric(
                          errorText: "Price should be a number"),
                      FormBuilderValidators.max(500,
                          errorText: "Price should be less than \$500")
                    ]),
                  ),
                  // * Product availability
                  FormDropDown(
                      title: "Availability",
                      isRequired: true,
                      formBuilderName: "isInStock",
                      items: [
                        DropdownMenuItem(
                            value: "true",
                            child: Text(
                              "In Stock",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400, fontSize: 16),
                            )),
                        DropdownMenuItem(
                            value: "false",
                            child: Text(
                              "Out of Stock",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400, fontSize: 16),
                            )),
                      ]),
                  // * Product sizes
                  FormMultiDropDown(
                    title: "Select Sizes",
                    isRequired: true,
                    controller: _sizeController,
                    items: const [
                      ValueItem(label: 'Small', value: 'S'),
                      ValueItem(label: 'Medium', value: 'M'),
                      ValueItem(label: 'Large', value: 'L'),
                      ValueItem(label: 'Extra Large', value: 'XL'),
                      ValueItem(label: 'EU 34', value: 'EU 34'),
                      ValueItem(label: 'EU 36', value: 'EU 36'),
                    ],
                    disabledOptions: const [
                      ValueItem(label: 'Small', value: 'S')
                    ],
                  ),

                  // * Product colors
                  FormMultiDropDown(
                    title: "Select Colors",
                    isRequired: true,
                    controller: _colorController,
                    items: const [
                      ValueItem(label: 'White', value: 'white'),
                      ValueItem(label: 'Black', value: 'black'),
                      ValueItem(label: 'Blue', value: 'blue'),
                      ValueItem(label: 'Green', value: 'green'),
                      ValueItem(label: 'Red', value: 'red'),
                      ValueItem(label: 'Yellow', value: 'yellow'),
                    ],
                    disabledOptions: const [
                      ValueItem(label: 'White', value: 'white')
                    ],
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
