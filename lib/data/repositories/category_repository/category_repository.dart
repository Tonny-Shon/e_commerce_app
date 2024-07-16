import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/features/shop/models/category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../services/firebase_storage_services.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  //variables
  final _db = FirebaseFirestore.instance;

  //Get all Categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('Categories').get();
      final list =
          snapshot.docs.map((e) => CategoryModel.fromSnapshoot(e)).toList();
      return list;
    } on FirebaseException catch (e) {
      throw Exception(e.toString());
    } on PlatformException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //Get sub categories
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final snapshot = await _db
          .collection('Categories')
          .where('ParentId', isEqualTo: categoryId)
          .get();

      final result =
          snapshot.docs.map((e) => CategoryModel.fromSnapshoot(e)).toList();

      return result;
    } on FirebaseException catch (e) {
      throw Exception(e.toString());
    } on PlatformException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //upload categories to the cloud
  Future<void> uploadDummyData(List<CategoryModel> categories) async {
    try {
      //upload all the categories along with their images
      final storage = Get.put(EFirebaseStorageServices());

      //loop through each category
      for (var category in categories) {
        //Get Image data link from the local assets
        final file = await storage.getImageDataFromAssets(category.name);

        //upload image and get it's url
        final url =
            await storage.uploadImageData('Categories', file, category.name);

        //assign url to category .image attribute
        category.image = url;

        //store category to firestore
        await _db
            .collection('Categories')
            .doc(category.id)
            .set(category.toJson());
      }
    } on FirebaseException catch (e) {
      throw Exception(e.toString());
    } on PlatformException catch (e) {
      throw Exception(e.toString());
    }
  }
}
