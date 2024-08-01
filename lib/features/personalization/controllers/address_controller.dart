import 'package:e_commerce_app/data/repositories/addresses/address_repository.dart';
import 'package:e_commerce_app/features/personalization/models/address_model.dart';
import 'package:e_commerce_app/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  RxBool refreshData = true.obs;
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());
  var address = <AddressModel>[].obs;
  final name = TextEditingController();
  final phoneNmber = TextEditingController();
  GlobalKey<FormState> addressFormkey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchAddresses();
  }

  Future<List<AddressModel>> allUserAddresses() async {
    try {
      final addresses = await addressRepository.fetchUserAddresses();

      return addresses;
    } catch (e) {
      ELoaders.erroSnackBar(title: 'Address Not Found', message: e.toString());
      return [];
    }
  }

  void fetchAddresses() async {
    try {
      var fetchedAddresses = await addressRepository.fetchUserAddresses();
      address.value = fetchedAddresses;
      if (address.isNotEmpty) {
        selectedAddress.value = address.first;
      }
    } catch (e) {
      ELoaders.erroSnackBar(title: 'Address not found', message: e.toString());
    }
  }

  Future selectAddress(AddressModel reselectedAddress) async {
    try {
      selectedAddress.value = reselectedAddress;
    } catch (e) {
      ELoaders.erroSnackBar(title: 'Error in selection', message: e.toString());
    }
  }
}
