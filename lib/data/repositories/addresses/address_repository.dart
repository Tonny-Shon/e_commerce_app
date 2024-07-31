import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/personalization/models/address_model.dart';

class AddressRepository extends GetxController {
  static AddressRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<AddressModel>> fetchUserAddresses() async {
    try {
      final result = await _db.collection('Addresses').get();
      return result.docs
          .map((documentSnapshot) =>
              AddressModel.fromDocumentSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> updateSelectedField(String addressId, bool selected) async {
    try {
      await _db
          .collection('Addresses')
          .doc(addressId)
          .update({'IsSelectedAddress': selected});
    } catch (e) {
      throw 'Unable to update your address selection. Try again later';
    }
  }

  Future<String> addAddress(AddressModel address) async {
    try {
      final currentAddress =
          await _db.collection('Addresses').add(address.toJson());
      return currentAddress.id;
    } on FirebaseException catch (e) {
      throw Exception(e.toString());
    } on PlatformException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
