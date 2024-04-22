import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/firebase_options.dart';
import 'package:flutter_ecommerce/repositories/product_repository.dart';
import 'package:flutter_ecommerce/screens/Home/home.dart';
import 'package:flutter_ecommerce/screens/ProductDetails/bloc/product_details_bloc.dart';
import 'package:flutter_ecommerce/screens/Products/bloc/products_bloc.dart';
import 'package:flutter_ecommerce/services/product_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // * products bloc provider
        BlocProvider<ProductsBloc>(
          create: (context) => ProductsBloc(
            repository: ProductRepository(
              productService: ProductService(
                  firestore: FirebaseFirestore.instance,
                  storage: FirebaseStorage.instance),
            ),
          )..add(FetchProductsEvent()),
        ),
        // * product details bloc provider
        BlocProvider<ProductDetailsBloc>(
          create: (context) => ProductDetailsBloc(
            productRepository: ProductRepository(
              productService: ProductService(
                  firestore: FirebaseFirestore.instance,
                  storage: FirebaseStorage.instance),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Ecommerce',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
            useMaterial3: true,
            splashColor: Colors.transparent),
        home: const Home(),
      ),
    );
  }
}
