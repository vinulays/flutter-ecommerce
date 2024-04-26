import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/screens/ProductDetails/bloc/product_details_bloc.dart';
import 'package:flutter_ecommerce/screens/ProductDetails/product_details.dart';
import 'package:flutter_ecommerce/services/product_service.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductSearchDelegate extends SearchDelegate<Product> {
  final String? categoryName;
  final String? categoryId;
  final ProductService productService = ProductService(
      firestore: FirebaseFirestore.instance, storage: FirebaseStorage.instance);

  ProductSearchDelegate({this.categoryName, this.categoryId});

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      textTheme: theme.textTheme.copyWith(
        titleLarge: GoogleFonts.poppins(
            color: Colors.black, fontSize: 18.0), // Customize text style
      ),
    );
  }

  @override
  String get searchFieldLabel =>
      categoryName == null ? 'Search for products' : 'Search in $categoryName';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
        future: categoryId == null
            ? productService.searchProducts(query)
            : productService.searchProductsInCategory(query, categoryId!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<Product> products = snapshot.data ?? [];
            return Container(
              margin: const EdgeInsets.only(top: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: Text(
                      "${products.length} Results",
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          Product product = products[index];
                          return ListTile(
                            title: Text(
                              product.title,
                              style: GoogleFonts.poppins(),
                            ),
                            onTap: () {
                              // close(context, product);
                              context
                                  .read<ProductDetailsBloc>()
                                  .add(FetchProductDetailsEvent(product.id!));
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ProductDetails(),
                                ),
                              );
                            },
                          );
                        }),
                  ),
                ],
              ),
            );
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: categoryId == null
          ? productService.searchProducts(query)
          : productService.searchProductsInCategory(query, categoryId!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          final List<Product> products = snapshot.data ?? [];

          return Container(
            margin: const EdgeInsets.only(top: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: Text(
                    "${products.length} Results",
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final Product product = products[index];

                      return ListTile(
                        title: Text(
                          product.title,
                          style: GoogleFonts.poppins(),
                        ),
                        onTap: () {
                          context
                              .read<ProductDetailsBloc>()
                              .add(FetchProductDetailsEvent(product.id!));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProductDetails(),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
