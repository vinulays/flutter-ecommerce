import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/models/review.dart';
import 'package:flutter_ecommerce/screens/Reviews/bloc/reviews_bloc.dart';
import 'package:flutter_ecommerce/ui/form_text_area.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewFormBottomSheet extends StatefulWidget {
  final String productId;
  const ReviewFormBottomSheet({super.key, required this.productId});

  @override
  State<ReviewFormBottomSheet> createState() => _ReviewFormBottomSheetState();
}

class _ReviewFormBottomSheetState extends State<ReviewFormBottomSheet> {
  final _formKey = GlobalKey<FormBuilderState>();
  double selectedRating = 0;

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: deviceData.size.width * 0.03),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        "Write a review",
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
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Rating: ",
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                  RatingBar.builder(
                    itemSize: 20,
                    glow: false,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        selectedRating = rating;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
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
                        String description =
                            _formKey.currentState!.value["description"];
                        User? user = FirebaseAuth.instance.currentUser;

                        String userId = user!.uid;

                        Review review = Review(
                            customerId: userId,
                            productId: widget.productId,
                            createdAt: DateTime.now(),
                            description: description,
                            rating: selectedRating);

                        context.read<ReviewsBloc>().add(AddReviewEvent(review));

                        Navigator.of(context).pop();
                      }
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.8),
                        ),
                      ),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(vertical: 17.88)),
                      backgroundColor: MaterialStateProperty.all(Colors.black),
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
              SizedBox(
                height: MediaQuery.of(context).viewInsets.bottom,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
