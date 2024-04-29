import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/models/review.dart';
import 'package:flutter_ecommerce/models/user.dart';
import 'package:flutter_ecommerce/screens/Reviews/bloc/reviews_bloc.dart';
import 'package:flutter_ecommerce/services/user_service.dart';
import 'package:flutter_ecommerce/ui/review_form_bottom_sheet.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';

class Reviews extends StatefulWidget {
  final String productId;
  final UserService userService = UserService(
      firestore: FirebaseFirestore.instance,
      firebaseAuth: FirebaseAuth.instance);
  Reviews({super.key, required this.productId});

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  List<Review> reviews = [];

  String getAvatarLetters(String name) {
    List<String> words = name.split(" ");
    String firstLetters = "";

    for (var word in words) {
      if (word.isNotEmpty) {
        firstLetters += word[0];
      }
    }

    return firstLetters;
  }

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

    return BlocBuilder<ReviewsBloc, ReviewsState>(
      builder: (context, state) {
        if (state is ReviewsLoaded) {
          reviews = state.reviews;
        }
        return Scaffold(
          body: Container(
            margin:
                EdgeInsets.symmetric(horizontal: deviceData.size.width * 0.03),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Reviews (${reviews.length})",
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25)),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                      height: 40,
                                      width: 40,
                                      margin: const EdgeInsets.only(right: 15),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey.withOpacity(0.2)),
                                      child: const Icon(Icons.close)),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            Expanded(
                                child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: reviews.length,
                                    itemBuilder: (BuildContext context, index) {
                                      return FutureBuilder(
                                          future: widget.userService
                                              .getUserDetails(
                                                  reviews[index].customerId),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              UserLocal user = snapshot.data!;

                                              return Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    border: Border.all(
                                                        color: Colors.black
                                                            .withOpacity(0.2))),
                                                margin: const EdgeInsets.only(
                                                    bottom: 18),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          if (user.avatarURL !=
                                                                  null &&
                                                              user.avatarURL !=
                                                                  "")
                                                            CachedNetworkImage(
                                                              imageUrl: user
                                                                  .avatarURL!,
                                                              imageBuilder:
                                                                  (context,
                                                                          imageProvider) =>
                                                                      Container(
                                                                height: 52,
                                                                width: 52,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  image: DecorationImage(
                                                                      image:
                                                                          imageProvider,
                                                                      fit: BoxFit
                                                                          .cover),
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                              ),
                                                              placeholder: (context,
                                                                      url) =>
                                                                  const SizedBox(
                                                                height: 52,
                                                                width: 52,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    CircularProgressIndicator()
                                                                  ],
                                                                ),
                                                              ),
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  const Icon(Icons
                                                                      .error),
                                                            ),
                                                          if (user.avatarURL ==
                                                                  null ||
                                                              user.avatarURL ==
                                                                  "")
                                                            CircleAvatar(
                                                              backgroundColor:
                                                                  Colors.black
                                                                      .withOpacity(
                                                                          0.1),
                                                              radius: 25,
                                                              child: Text(
                                                                getAvatarLetters(
                                                                    user.displayName),
                                                                style: GoogleFonts
                                                                    .poppins(
                                                                        fontSize:
                                                                            20),
                                                              ),
                                                            ),
                                                          const SizedBox(
                                                            width: 15,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                user.displayName,
                                                                style: GoogleFonts
                                                                    .poppins(
                                                                        fontSize:
                                                                            15),
                                                              ),
                                                              Text(
                                                                Jiffy.parse(reviews[
                                                                            index]
                                                                        .createdAt
                                                                        .toString())
                                                                    .format(
                                                                        pattern:
                                                                            "do MMMM yyyy"),
                                                                style: GoogleFonts.poppins(
                                                                    fontSize:
                                                                        13,
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.5)),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      RatingBar.builder(
                                                        ignoreGestures: true,
                                                        itemSize: 20,
                                                        glow: false,
                                                        initialRating:
                                                            reviews[index]
                                                                .rating,
                                                        minRating: 1,
                                                        direction:
                                                            Axis.horizontal,
                                                        allowHalfRating: false,
                                                        itemCount: 5,
                                                        itemPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    1.0),
                                                        itemBuilder:
                                                            (context, _) =>
                                                                const Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                        ),
                                                        onRatingUpdate:
                                                            (rating) {},
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        reviews[index]
                                                            .description,
                                                        style: GoogleFonts
                                                            .poppins(),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            } else {
                                              return Container();
                                            }
                                          });
                                    }))
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Wrap(
                                      children: [
                                        ReviewFormBottomSheet(
                                          productId: widget.productId,
                                        ),
                                      ],
                                    );
                                  });
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
                                  MaterialStateProperty.all(Colors.black),
                            ),
                            child: Text(
                              "Write a review",
                              style: GoogleFonts.poppins(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
