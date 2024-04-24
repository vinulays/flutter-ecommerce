import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/firebase_options.dart';
import 'package:flutter_ecommerce/repositories/cart_repository.dart';
import 'package:flutter_ecommerce/repositories/product_repository.dart';
import 'package:flutter_ecommerce/screens/CategoryDetails/bloc/category_details_bloc.dart';
import 'package:flutter_ecommerce/screens/Login/bloc/authentication_bloc.dart';
import 'package:flutter_ecommerce/screens/Login/login.dart';
import 'package:flutter_ecommerce/screens/ProductDetails/bloc/product_details_bloc.dart';
import 'package:flutter_ecommerce/screens/Products/bloc/products_bloc.dart';
import 'package:flutter_ecommerce/screens/ShoppingCart/bloc/shopping_cart_bloc.dart';
import 'package:flutter_ecommerce/services/auth_service.dart';
import 'package:flutter_ecommerce/services/cart_service.dart';
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
        // * category details bloc provider
        BlocProvider<CategoryDetailsBloc>(
          create: (context) => CategoryDetailsBloc(
            productRepository: ProductRepository(
              productService: ProductService(
                  firestore: FirebaseFirestore.instance,
                  storage: FirebaseStorage.instance),
            ),
          ),
        ),
        // * shopping cart bloc provider
        BlocProvider<ShoppingCartBloc>(
          create: (context) => ShoppingCartBloc(
            cartRepository: CartRepository(
              cartService: CartService(),
            ),
          ),
        ),
        BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc(
                firebaseAuth: FirebaseAuth.instance,
                authService: AuthService(
                    firebaseAuth: FirebaseAuth.instance,
                    firestore: FirebaseFirestore.instance)))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Ecommerce',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
            useMaterial3: true,
            splashColor: Colors.transparent),
        home: const Login(),
      ),
    );
  }
}
