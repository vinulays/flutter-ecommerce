import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/screens/ProductDetails/bloc/product_details_bloc.dart';
import 'package:flutter_ecommerce/screens/Products/bloc/products_bloc.dart';
import 'package:flutter_ecommerce/ui/form_drop_down.dart';
import 'package:flutter_ecommerce/ui/form_input_field.dart';
import 'package:flutter_ecommerce/ui/form_multi_drop_down.dart';
import 'package:flutter_ecommerce/ui/form_text_area.dart';
import 'package:flutter_ecommerce/utils/product_categories.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class ProductForm extends StatefulWidget {
  final Product? product;
  final bool isUpdate;
  const ProductForm({super.key, required this.isUpdate, this.product});

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  final ImagePicker _picker = ImagePicker();

  final MultiSelectController _sizeController = MultiSelectController();
  final MultiSelectController _colorController = MultiSelectController();

  File? _thumbnailImage;
  List<XFile> coverImages = [];

  // * for product updation
  String thumbnailURL = "";
  List<String> imageURLs = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.isUpdate && _formKey.currentState != null) {
        _formKey.currentState!.patchValue({
          "title": widget.product!.title,
          "description": widget.product!.description,
          "price": widget.product!.price.toString(),
          "isInStock": (widget.product!.isInStock) ? "true" : "false",
          "categoryId": widget.product!.categoryId
        });
      }

      _sizeController.setOptions(const [
        ValueItem(label: 'Small', value: 'S'),
        ValueItem(label: 'Medium', value: 'M'),
        ValueItem(label: 'Large', value: 'L'),
        ValueItem(label: 'Extra Large', value: 'XL'),
        ValueItem(label: 'EU 34', value: 'EU 34'),
        ValueItem(label: 'EU 36', value: 'EU 36'),
      ]);

      _colorController.setOptions(const [
        ValueItem(label: 'White', value: 'white'),
        ValueItem(label: 'Black', value: 'black'),
        ValueItem(label: 'Blue', value: 'blue'),
        ValueItem(label: 'Green', value: 'green'),
        ValueItem(label: 'Red', value: 'red'),
        ValueItem(label: 'Yellow', value: 'yellow'),
      ]);

      List<ValueItem> selectedSizeOptions = _sizeController.options
          .where((option) => widget.product!.sizes.contains(option.value))
          .toList();

      List<ValueItem> selectedColorOptions = _colorController.options
          .where((option) => widget.product!.colors.contains(option.value))
          .toList();

      _sizeController.setSelectedOptions(selectedSizeOptions);
      _colorController.setSelectedOptions(selectedColorOptions);
    });

    thumbnailURL = widget.product!.thumbnailURL;
    imageURLs.addAll(widget.product!.imageURLs);
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _thumbnailImage = File(pickedFile.path);

        _formKey.currentState?.fields["thumbnailImage"]
            ?.didChange(_thumbnailImage);
      });
    } else {
      if (!widget.isUpdate) {
        _formKey.currentState?.fields["thumbnailImage"]?.didChange(null);
      }
    }
  }

  void pickCoverPhotos() async {
    final List<XFile> selectedImages = await _picker.pickMultiImage();

    if (selectedImages.isNotEmpty) {
      setState(() {
        coverImages.addAll(selectedImages);

        _formKey.currentState?.fields["coverImages"]?.didChange(coverImages);
      });
    } else {
      if (!widget.isUpdate) {
        _formKey.currentState?.fields["coverImages"]?.didChange(null);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: deviceData.size.width * 0.05),
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
                Text("${widget.isUpdate == true ? "Update" : "Add a"} Product",
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
                  FormBuilder(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                errorText:
                                    "Title should be longer than 10 letters"),
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
                            validators: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText: "Availability is required")
                            ]),
                            items: [
                              DropdownMenuItem(
                                  value: "true",
                                  child: Text(
                                    "In Stock",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16),
                                  )),
                              DropdownMenuItem(
                                  value: "false",
                                  child: Text(
                                    "Out of Stock",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16),
                                  )),
                            ]),
                        // * Product sizes
                        FormMultiDropDown(
                          title: "Select Sizes",
                          isRequired: false,
                          controller: _sizeController,
                          items: const [
                            ValueItem(label: 'Small', value: 'S'),
                            ValueItem(label: 'Medium', value: 'M'),
                            ValueItem(label: 'Large', value: 'L'),
                            ValueItem(label: 'Extra Large', value: 'XL'),
                            ValueItem(label: 'EU 34', value: 'EU 34'),
                            ValueItem(label: 'EU 36', value: 'EU 36'),
                          ],
                          disabledOptions: const [],
                        ),

                        // * Product colors
                        FormMultiDropDown(
                          title: "Select Colors",
                          isRequired: false,
                          controller: _colorController,
                          items: const [
                            ValueItem(label: 'White', value: 'white'),
                            ValueItem(label: 'Black', value: 'black'),
                            ValueItem(label: 'Blue', value: 'blue'),
                            ValueItem(label: 'Green', value: 'green'),
                            ValueItem(label: 'Red', value: 'red'),
                            ValueItem(label: 'Yellow', value: 'yellow'),
                          ],
                          disabledOptions: const [],
                        ),
                        // * Product category
                        FormDropDown(
                            validators: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText: "Category is required")
                            ]),
                            title: "Category",
                            isRequired: true,
                            formBuilderName: "categoryId",
                            items: productCategories
                                .map((category) => DropdownMenuItem(
                                    value: category.id,
                                    child: Text(
                                      category.name,
                                      style: GoogleFonts.poppins(fontSize: 16),
                                    )))
                                .toList()),
                        // * Thumbnail image
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Thumbnail Image",
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
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
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (_thumbnailImage != null)
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    height: 140,
                                    width: 140,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(_thumbnailImage!)),
                                        shape: BoxShape.rectangle,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                  Positioned(
                                      top: -5,
                                      right: -5,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _thumbnailImage = null;

                                            _formKey.currentState
                                                ?.fields["thumbnailImage"]
                                                ?.didChange(null);
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 35,
                                          decoration: const BoxDecoration(
                                              color: Colors.red,
                                              shape: BoxShape.circle),
                                          child: const Center(
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                            // * Thumbnail image for product update
                            if (thumbnailURL != "")
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    height: 140,
                                    width: 140,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(thumbnailURL)),
                                        shape: BoxShape.rectangle,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                  Positioned(
                                      top: -5,
                                      right: -5,
                                      child: GestureDetector(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  backgroundColor: Colors.white,
                                                  title: Text(
                                                    "Delete image",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  content: Text(
                                                    "Do you want to remove this image from the product?",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text(
                                                          "No",
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize: 14),
                                                        )),
                                                    TextButton(
                                                        onPressed: () async {
                                                          // * deleting the image from the product document in firestore
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'products')
                                                              .doc(widget
                                                                  .product!.id)
                                                              .update({
                                                            'thumbnailURL': "",
                                                          });
                                                          setState(() {
                                                            _thumbnailImage =
                                                                null;
                                                            thumbnailURL = "";

                                                            _formKey
                                                                .currentState
                                                                ?.fields[
                                                                    "thumbnailImage"]
                                                                ?.didChange(
                                                                    null);
                                                          });
                                                          if (context.mounted) {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          }
                                                        },
                                                        child: Text(
                                                          "Yes",
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize: 14),
                                                        )),
                                                  ],
                                                );
                                              });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 35,
                                          decoration: const BoxDecoration(
                                              color: Colors.red,
                                              shape: BoxShape.circle),
                                          child: const Center(
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                            if (_thumbnailImage != null || thumbnailURL != "")
                              const SizedBox(
                                width: 10,
                              ),
                            FormBuilderField(
                              name: "thumbnailImage",
                              builder: (FormFieldState<dynamic> field) {
                                return GestureDetector(
                                  onTap: () {
                                    if (_thumbnailImage == null) {
                                      pickImage();
                                    }
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 140,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.rectangle,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.camera_alt,
                                          size: 35,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Upload",
                                          style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          "Image",
                                          style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (_thumbnailImage == null &&
                                    !widget.isUpdate) {
                                  return "Thumbnail photo is required";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                        if (_formKey.currentState != null &&
                            _formKey.currentState?.fields["thumbnailImage"]
                                    ?.value ==
                                null)
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Text(
                              "Thumbnail image is required",
                              style: GoogleFonts.poppins(
                                  fontSize: 14, color: const Color(0xffba000d)),
                            ),
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                        // * Cover images
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Cover Images",
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
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
                          height: 20,
                        ),
                        Wrap(
                          runSpacing: 20,
                          children: [
                            if (coverImages.isNotEmpty)
                              Wrap(
                                spacing: 20,
                                children:
                                    List.generate(coverImages.length, (index) {
                                  return Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        height: 140,
                                        width: 140,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: FileImage(File(
                                                    coverImages[index].path))),
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                      ),
                                      Positioned(
                                          top: -5,
                                          right: -5,
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                coverImages.removeAt(index);

                                                if (coverImages.isEmpty) {
                                                  _formKey.currentState
                                                      ?.fields["coverImages"]
                                                      ?.didChange(null);
                                                }
                                              });
                                            },
                                            child: Container(
                                              height: 35,
                                              width: 35,
                                              decoration: const BoxDecoration(
                                                  color: Colors.red,
                                                  shape: BoxShape.circle),
                                              child: const Center(
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ))
                                    ],
                                  );
                                }),
                              ),
                            if (coverImages.isNotEmpty)
                              const SizedBox(
                                width: 10,
                              ),
                            if (imageURLs.isNotEmpty)
                              Wrap(
                                spacing: 20,
                                runSpacing: 20,
                                children:
                                    List.generate(imageURLs.length, (index) {
                                  return Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        height: 140,
                                        width: 140,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image:
                                                NetworkImage(imageURLs[index]),
                                          ),
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                      Positioned(
                                          top: -5,
                                          right: -5,
                                          child: GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      backgroundColor:
                                                          Colors.white,
                                                      title: Text(
                                                        "Delete image",
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                      ),
                                                      content: Text(
                                                        "Do you want to remove this image from the product?",
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 14),
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Text(
                                                              "No",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                      fontSize:
                                                                          14),
                                                            )),
                                                        TextButton(
                                                            onPressed:
                                                                () async {
                                                              await FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'products')
                                                                  .doc(widget
                                                                      .product!
                                                                      .id)
                                                                  .update({
                                                                'imageURLs':
                                                                    FieldValue
                                                                        .arrayRemove([
                                                                  imageURLs[
                                                                      index]
                                                                ]),
                                                              });
                                                              setState(() {
                                                                imageURLs
                                                                    .removeAt(
                                                                        index);

                                                                if (imageURLs
                                                                    .isEmpty) {
                                                                  _formKey
                                                                      .currentState
                                                                      ?.fields[
                                                                          "coverImages"]
                                                                      ?.didChange(
                                                                          null);
                                                                }
                                                              });
                                                              if (context
                                                                  .mounted) {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              }
                                                            },
                                                            child: Text(
                                                              "Yes",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                      fontSize:
                                                                          14),
                                                            )),
                                                      ],
                                                    );
                                                  });
                                            },
                                            child: Container(
                                              height: 35,
                                              width: 35,
                                              decoration: const BoxDecoration(
                                                  color: Colors.red,
                                                  shape: BoxShape.circle),
                                              child: const Center(
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ))
                                    ],
                                  );
                                }),
                              ),
                            if (coverImages.isNotEmpty || imageURLs.isNotEmpty)
                              const SizedBox(
                                width: 10,
                              ),
                            FormBuilderField(
                              name: "coverImages",
                              builder: (FormFieldState<dynamic> field) {
                                return GestureDetector(
                                  onTap: () {
                                    pickCoverPhotos();
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 140,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.rectangle,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.camera_alt,
                                          size: 35,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Upload",
                                          style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          "Images",
                                          style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (coverImages.isEmpty && !widget.isUpdate) {
                                  return "Cover images are required.";
                                }

                                return null;
                              },
                            ),
                          ],
                        ),
                        if (_formKey.currentState != null &&
                            _formKey.currentState?.fields["coverImages"]
                                    ?.value ==
                                null)
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Text(
                              "Cover images are required",
                              style: GoogleFonts.poppins(
                                  fontSize: 14, color: const Color(0xffba000d)),
                            ),
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                        // * Submit button
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 20),
                          child: TextButton(
                              onPressed: () async {
                                if (_formKey.currentState!.saveAndValidate()) {
                                  if (!widget.isUpdate) {
                                    Map<String, dynamic> formData =
                                        Map.from(_formKey.currentState!.value);

                                    List<String> sizes = [];
                                    List<String> colors = [];

                                    if (_sizeController
                                        .selectedOptions.isNotEmpty) {
                                      for (var option
                                          in _sizeController.selectedOptions) {
                                        sizes.add(option.value);
                                      }
                                    }

                                    if (_colorController
                                        .selectedOptions.isNotEmpty) {
                                      for (var option
                                          in _colorController.selectedOptions) {
                                        colors.add(option.value);
                                      }
                                    }

                                    formData['sizes'] = sizes;
                                    formData['colors'] = colors;

                                    context
                                        .read<ProductsBloc>()
                                        .add(AddProductEvent(formData));

                                    // * Going back after the addition
                                    Navigator.of(context).pop();
                                  } else {
                                    // * updating the product
                                    // ! if coverimages & thumbnail image null, don't update them in firestore
                                    Map<String, dynamic> formData =
                                        Map.from(_formKey.currentState!.value);

                                    List<String> sizes = [];
                                    List<String> colors = [];

                                    if (_sizeController
                                        .selectedOptions.isNotEmpty) {
                                      for (var option
                                          in _sizeController.selectedOptions) {
                                        sizes.add(option.value);
                                      }
                                    }

                                    if (_colorController
                                        .selectedOptions.isNotEmpty) {
                                      for (var option
                                          in _colorController.selectedOptions) {
                                        colors.add(option.value);
                                      }
                                    }

                                    formData['sizes'] = sizes;
                                    formData['colors'] = colors;
                                    formData["productId"] = widget.product!.id;

                                    context
                                        .read<ProductsBloc>()
                                        .add(UpdateProductEvent(formData));

                                    context.read<ProductDetailsBloc>().add(
                                        FetchProductDetailsEvent(
                                            widget.product!.id!));

                                    // * Going back to the product details page
                                    Navigator.of(context).pop();
                                  }
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
                                    const EdgeInsets.symmetric(
                                        vertical: 17.88)),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                              ),
                              child: BlocBuilder<ProductsBloc, ProductsState>(
                                builder: (context, state) {
                                  if (state is ProductAdding) {
                                    return const SizedBox(
                                      height: 27,
                                      width: 27,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    );
                                  }
                                  return Text(
                                    "Submit",
                                    style: GoogleFonts.poppins(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  );
                                },
                              )),
                        ),
                      ],
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
