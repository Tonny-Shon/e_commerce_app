import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/data/repositories/authentication/authentication_repository.dart';
import 'package:e_commerce_app/utils/popups/loaders.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../features/authentication/controller/signup/exceptions.dart';
import '../../../features/authentication/models/user_model/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

// save the use records
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      //throw EFirebaseException(e.code).message;
      ELoaders.erroSnackBar(title: 'Oops', message: e.toString());
    } on FormatException catch (e) {
      //throw EFormatException(e.code).message;
      ELoaders.erroSnackBar(title: 'Oops', message: e.toString());
    } on PlatformException catch (e) {
      //throw EPlatformException(e.code).message;
      ELoaders.erroSnackBar(title: 'Oops', message: e.toString());
    }
  }

  //Function to fetch the user details based on the user id
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      throw EFirebaseException(code: 'An Error', message: e.toString());
      //ELoaders.erroSnackBar(title: 'Oops', message: e.toString());
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  //function to update user data in firestore
  Future<void> updateUserDetails(UserModel updateUser) async {
    try {
      await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .update(updateUser.toJson());
    } on FirebaseException catch (e) {
      throw EFirebaseException(code: 'An Error', message: e.toString());
      //ELoaders.erroSnackBar(title: 'Oops', message: e.toString());
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  //updating a specific field in the users collection
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .update(json);
    } on FirebaseException catch (e) {
      throw EFirebaseException(code: 'An Error', message: e.toString());
      //ELoaders.erroSnackBar(title: 'Oops', message: e.toString());
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  //remove the user data from firestore
  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection("Users").doc(userId).delete();
    } on FirebaseException catch (e) {
      throw EFirebaseException(code: 'An Error', message: e.toString());
      //ELoaders.erroSnackBar(title: 'Oops', message: e.toString());
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  //upload any image
  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw EFirebaseException(code: 'An Error', message: e.toString());
      //ELoaders.erroSnackBar(title: 'Oops', message: e.toString());
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }
}
