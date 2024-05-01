import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/firebase_options.dart';
import 'package:flutter_ecommerce/repositories/auth_repository.dart';
import 'package:flutter_ecommerce/repositories/cart_repository.dart';
import 'package:flutter_ecommerce/repositories/flashsale_repository.dart';
import 'package:flutter_ecommerce/repositories/order_repository.dart';
import 'package:flutter_ecommerce/repositories/product_repository.dart';
import 'package:flutter_ecommerce/repositories/review_repository.dart';
import 'package:flutter_ecommerce/repositories/user_repository.dart';
import 'package:flutter_ecommerce/repositories/wishlist_repository.dart';
import 'package:flutter_ecommerce/screens/CategoryDetails/bloc/category_details_bloc.dart';
import 'package:flutter_ecommerce/screens/FlashSales/bloc/flashsale_bloc.dart';
import 'package:flutter_ecommerce/screens/Login/bloc/authentication_bloc.dart';
import 'package:flutter_ecommerce/screens/Orders/bloc/orders_bloc.dart';
import 'package:flutter_ecommerce/screens/ProductDetails/bloc/product_details_bloc.dart';
import 'package:flutter_ecommerce/screens/Products/bloc/products_bloc.dart';
import 'package:flutter_ecommerce/screens/Profile/bloc/user_bloc.dart';
import 'package:flutter_ecommerce/screens/Reviews/bloc/reviews_bloc.dart';
import 'package:flutter_ecommerce/screens/ShoppingCart/bloc/shopping_cart_bloc.dart';
import 'package:flutter_ecommerce/screens/Welcome/welcome.dart';
import 'package:flutter_ecommerce/screens/Wishlist/bloc/wishlist_bloc.dart';
import 'package:flutter_ecommerce/services/auth_service.dart';
import 'package:flutter_ecommerce/services/cart_service.dart';
import 'package:flutter_ecommerce/services/flashsale_service.dart';
import 'package:flutter_ecommerce/services/order_service.dart';
import 'package:flutter_ecommerce/services/product_service.dart';
import 'package:flutter_ecommerce/services/review_service.dart';
import 'package:flutter_ecommerce/services/user_service.dart';
import 'package:flutter_ecommerce/services/wishlist_service.dart';

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
        // * bloc (business logic) providers to distribute the state among the application
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
        // * Auth bloc provider
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(
            authRepository: AuthRepository(
              authService: AuthService(
                  storage: FirebaseStorage.instance,
                  firebaseAuth: FirebaseAuth.instance,
                  firestore: FirebaseFirestore.instance),
            ),
          ),
        ),
        // *Wishlist bloc provider
        BlocProvider<WishlistBloc>(
          create: (context) => WishlistBloc(
            wishListRepository: WishListRepository(
                wishListService:
                    WishListService(fireStore: FirebaseFirestore.instance)),
            authRepository: AuthRepository(
              authService: AuthService(
                  storage: FirebaseStorage.instance,
                  firebaseAuth: FirebaseAuth.instance,
                  firestore: FirebaseFirestore.instance),
            ),
          ),
        ),
        // * User details bloc provider
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(
            userRepository: UserRepository(
              userService: UserService(
                  firestore: FirebaseFirestore.instance,
                  firebaseAuth: FirebaseAuth.instance),
            ),
          ),
        ),
        // * Order bloc provider
        BlocProvider<OrdersBloc>(
          create: (context) => OrdersBloc(
            repository: OrderRepository(
              orderService: OrderService(
                  firestore: FirebaseFirestore.instance,
                  firebaseAuth: FirebaseAuth.instance),
            ),
          ),
        ),
        // * flash sale bloc provider
        BlocProvider<FlashsaleBloc>(
          create: (context) => FlashsaleBloc(
            flashSaleRepository: FlashSaleRepository(
              flashSaleService: FlashSaleService(),
            ),
          ),
        ),
        // * reviews bloc provider
        BlocProvider<ReviewsBloc>(
          create: (context) => ReviewsBloc(
            repository: ReviewRepository(
              reviewService:
                  ReviewService(firestore: FirebaseFirestore.instance),
            ),
          ),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Ecommerce',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
            useMaterial3: true,
            splashColor: Colors.transparent),
        home: const Welcome(),
      ),
    );
  }
}
