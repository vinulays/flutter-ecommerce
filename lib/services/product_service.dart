import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:image_picker/image_picker.dart';

class ProductService {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  ProductService(
      {required FirebaseFirestore firestore, required FirebaseStorage storage})
      : _firestore = firestore,
        _storage = storage;

  Future<List<Product>> getProducts() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('products')
          .orderBy("createdAt", descending: true)
          .get(const GetOptions(source: Source.server));

      List<Product> products = [];

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data();

        Product product = Product(
          id: doc.id,
          title: data['title'],
          description: data['description'],
          price: double.parse(data["price"].toString()),
          rating: double.parse(data['rating']
              .toString()), // * converting firebase number format to double format
          categoryId: data["categoryId"],
          isInStock: data["isInStock"],
          thumbnailURL: data["thumbnailURL"],
          imageURLs: List<String>.from(
            data["imageURLs"],
          ),
          createdAt: data["createdAt"].toDate(),
          sizes: List<String>.from(data["sizes"]),
          colors: List<String>.from(data["colors"]),
        );

        products.add(product);
      }

      return products;
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }

  Future<Product> getProductById(String productId) async {
    try {
      DocumentSnapshot productDoc =
          await _firestore.collection('products').doc(productId).get();

      if (productDoc.exists) {
        Map<String, dynamic> data = productDoc.data() as Map<String, dynamic>;

        Product product = Product(
          id: productDoc.id,
          title: data['title'],
          description: data['description'],
          price: double.parse(data["price"].toString()),
          rating: double.parse(data['rating']
              .toString()), // * converting firebase number format to double format
          categoryId: data["categoryId"],
          isInStock: data["isInStock"],
          thumbnailURL: data["thumbnailURL"],
          imageURLs: List<String>.from(
            data["imageURLs"],
          ),
          createdAt: data["createdAt"].toDate(),
          sizes: List<String>.from(data["sizes"]),
          colors: List<String>.from(data["colors"]),
        );

        return product;
      } else {
        throw Exception('Challenge with id $productId not found');
      }
    } catch (e) {
      // Handle errors if any
      throw Exception('Failed to get product: $e');
    }
  }

  Future<List<Product>> getProductsByCategoryId(String categoryId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('products')
          .where('categoryId', isEqualTo: categoryId)
          .get(const GetOptions(source: Source.server));

      List<Product> products = [];

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        Product product = Product(
          id: doc.id,
          title: data['title'],
          description: data['description'],
          price: double.parse(data["price"].toString()),
          rating: double.parse(data['rating']
              .toString()), // * converting firebase number format to double format
          categoryId: data["categoryId"],
          isInStock: data["isInStock"],
          thumbnailURL: data["thumbnailURL"],
          imageURLs: List<String>.from(
            data["imageURLs"],
          ),
          createdAt: data["createdAt"].toDate(),
          sizes: List<String>.from(data["sizes"]),
          colors: List<String>.from(data["colors"]),
        );

        products.add(product);
      }

      return products;
    } catch (e) {
      // Handle errors if any
      throw Exception('Failed to get products by the category: $e');
    }
  }

  Future<void> addProduct(Map<String, dynamic> formData) async {
    String? thumbnailURL = await uploadImage(formData["thumbnailImage"]);
    List<String?> coverUrls = [];

    try {
      coverUrls = await Future.wait(
        (formData["coverImages"] as List<XFile>).map(
          (coverImage) async {
            try {
              Reference ref =
                  _storage.ref().child("productImages").child(coverImage.name);

              UploadTask uploadTask = ref.putFile(File(coverImage.path));

              String url = await (await uploadTask).ref.getDownloadURL();

              return url;
            } catch (e) {
              return null;
            }
          },
        ),
      );

      await _firestore.collection("products").add({
        "title": formData["title"],
        "description": formData["description"],
        "categoryId": formData["categoryId"],
        "thumbnailURL": thumbnailURL,
        "imageURLs": coverUrls,
        "createdAt": DateTime.now(),
        "colors": formData["colors"],
        "sizes": formData["sizes"],
        "isInStock": bool.parse(formData["isInStock"]),
        "rating": 0,
        "price": double.parse(formData["price"].toString())
      });
    } catch (e) {
      throw Exception("Failed to add product: $e");
    }
  }

  Future<void> updateProduct(Map<String, dynamic> formData) async {
    String? thumbnailURL;
    List<String?> coverUrls = [];

    try {
      if (formData["thumbnailImage"] != null) {
        thumbnailURL = await uploadImage(formData["thumbnailImage"]);
        formData["thumbnailImage"] = thumbnailURL;
      }

      if (formData["coverImages"] != null) {
        coverUrls = await Future.wait(
          (formData["coverImages"] as List<XFile>).map(
            (coverImage) async {
              try {
                Reference ref = _storage
                    .ref()
                    .child("productImages")
                    .child(coverImage.name);

                UploadTask uploadTask = ref.putFile(File(coverImage.path));

                String url = await (await uploadTask).ref.getDownloadURL();

                return url;
              } catch (e) {
                return null;
              }
            },
          ),
        );

        formData["coverImages"] = coverUrls;
      }

      await _firestore
          .collection("products")
          .doc(formData["productId"])
          .update({
        "title": formData["title"],
        "description": formData["description"],
        "categoryId": formData["categoryId"],
        if (thumbnailURL != null) "thumbnailURL": thumbnailURL,
        if (coverUrls.isNotEmpty) "imageURLs": FieldValue.arrayUnion(coverUrls),
        "colors": formData["colors"],
        "sizes": formData["sizes"],
        "isInStock": bool.parse(formData["isInStock"]),
        "price": double.parse(formData["price"].toString())
      });
    } catch (e) {
      throw Exception("Failed to update the product: $e");
    }
  }

  Future<String?> uploadImage(File imageFile) async {
    try {
      Reference ref = _storage
          .ref()
          .child("productImages")
          .child(imageFile.path.split('/').last);

      UploadTask uploadTask = ref.putFile(imageFile);

      String url = await (await uploadTask).ref.getDownloadURL();

      return url;
    } catch (e) {
      throw Exception('Error uploading image: $e');
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      DocumentReference productRef =
          _firestore.collection("products").doc(productId);

      DocumentSnapshot productSnapshot = await productRef.get();
      List<String> imageURLs =
          List<String>.from(productSnapshot.get("imageURLs"));
      String thumbnailURL = productSnapshot.get("thumbnailURL");

      // * deleting the product
      await productRef.delete();

      // * deleting images
      String thumbnailFileName =
          thumbnailURL.split('%2F').last.split('?').first;

      if (!imageURLs.any((url) => url.contains(thumbnailFileName))) {
        imageURLs.add(thumbnailURL);
      }

      for (String url in imageURLs) {
        await _storage.refFromURL(url).delete();
      }
    } catch (e) {
      throw Exception("Failed to delete the product: $e");
    }
  }
}
