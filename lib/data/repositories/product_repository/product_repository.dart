import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/features/shop/models/product_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  //firestore instance for database information
  final _db = FirebaseFirestore.instance;

  Future<List<ProductModel>> getAllProducts() async {
    try {
      final query = await _db.collection('Products').get();
      return query.docs.map((e) => ProductModel.fromQuerySnapshot(e)).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //get limited featured products
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final querySnapshot = await _db
          .collection('Products')
          .where('IsFeatured', isEqualTo: true)
          .get();

      return querySnapshot.docs.map((doc) {
        return ProductModel.fromJson(doc);
      }).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //get limited featured products
  Future<List<ProductModel>> getAllFeaturedProducts() async {
    try {
      final querySnapshot = await _db
          .collection('Products')
          .where('IsFeatured', isEqualTo: true)
          .get();

      return querySnapshot.docs.map((doc) {
        return ProductModel.fromJson(doc);
      }).toList();
    } on FirebaseException catch (e) {
      throw Exception(e.toString());
    } on PlatformException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception('Something went wrong. Please try again');
    }
  }

  //get products based on the brand
  Future<List<ProductModel>> featuredProductsByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      //print('Fetched documents; ${querySnapshot.docs.length}');
      final List<ProductModel> productList = querySnapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();

      return productList;
    } on FirebaseException catch (e) {
      throw Exception(e.toString());
    } on PlatformException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception('Something went wrong. Please try again');
    }
  }

  Future<List<ProductModel>> getProductsForBrand(
      {required String brandId, int limit = -1}) async {
    try {
      final querySnapshot = limit == -1
          ? await _db
              .collection('Products')
              .where('Brand.Id', isEqualTo: brandId)
              .get()
          : await _db
              .collection('Products')
              .where('Brand.Id', isEqualTo: brandId)
              .limit(limit)
              .get();

      final products =
          querySnapshot.docs.map((doc) => ProductModel.fromJson(doc)).toList();
      return products;
    } on FirebaseException catch (e) {
      throw Exception(e.toString());
    } on PlatformException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception('Something went wrong. Please try again');
    }
  }

  Future<List<ProductModel>> getFavoriteProducts(
      List<String> productIds) async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();
      return snapshot.docs
          .map((querySnapshot) => ProductModel.fromJson(querySnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw Exception(e.toString());
    } on PlatformException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception('Something went wrong. Please try again');
    }
  }

  //Get category or sub category data
  Future<List<ProductModel>> getProductsForCategory(
      {required String categoryId, int limit = -1}) async {
    QuerySnapshot productCategoryQuery = limit == -1
        ? await _db
            .collection('ProductCategory')
            .where('CategoryId', isEqualTo: categoryId)
            .get()
        : await _db
            .collection('ProductCategory')
            .where('CategoryId', isEqualTo: categoryId)
            .limit(limit)
            .get();

    //Extract productIds from the document
    List<String> productIds = productCategoryQuery.docs
        .map((doc) => doc['ProductId'] as String)
        .toList();

    //Query to get all documents where the brandIs is in the list of brandIds, FieldPath.documentId to query documents in collection
    final productsQuery = await _db
        .collection('Products')
        .where(FieldPath.documentId, whereIn: productIds)
        .get();

    //Extract brand names or other relevant data from the documents
    List<ProductModel> products = productsQuery.docs
        .map((doc) => ProductModel.fromQuerySnapshot(doc))
        .toList();

    return products;
  }

  //searching for products in the system
  Future<List<ProductModel>> searchProducts(String searchTerm) async {
    try {
      final query = _db
          .collection('Products')
          .where('name', isGreaterThanOrEqualTo: searchTerm)
          .where('name', isLessThanOrEqualTo: '$searchTerm\uf8ff')
          .get();

      final result = (await query)
          .docs
          .map((e) => ProductModel.fromQuerySnapshot(e))
          .toList();
      return result;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
