import 'package:e_commerce_app/data/repositories/addresses/address_repository.dart';
import 'package:e_commerce_app/features/authentication/controller/network_manager/network_manager.dart';
import 'package:e_commerce_app/features/personalization/models/address_model.dart';
import 'package:e_commerce_app/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  RxBool refreshData = true.obs;
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());

  final name = TextEditingController();
  final phoneNmber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressFormkey = GlobalKey<FormState>();

  Future<List<AddressModel>> allUserAddresses() async {
    try {
      final addresses = await addressRepository.fetchUserAddresses();
      selectedAddress.value = addresses.firstWhere(
          (element) => element.selectedAddress,
          orElse: AddressModel.empty);
      return addresses;
    } catch (e) {
      ELoaders.erroSnackBar(title: 'Address Not Found', message: e.toString());
      return [];
    }
  }

  Future selectAddress(AddressModel reselectedAddress) async {
    try {
      Get.defaultDialog(
        title: '',
        onWillPop: () async {
          return false;
        },
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        content: const CircularProgressIndicator(),
      );

      //Clear the selected field
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepository.updateSelectedField(
            selectedAddress.value.id, false);
      }
      reselectedAddress.selectedAddress = true;
      selectedAddress.value = reselectedAddress;
      await addressRepository.updateSelectedField(
          selectedAddress.value.id, true);
    } catch (e) {
      ELoaders.erroSnackBar(title: 'Error in selection', message: e.toString());
    }
  }

  Future addNewAddress() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }
      if (!addressFormkey.currentState!.validate()) {
        return;
      }
      final address = AddressModel(
        name: name.text.trim(),
        id: '',
        phoneNumber: phoneNmber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        country: country.text.trim(),
      );
      final id = await addressRepository.addAddress(address);
      address.id = id;
      selectedAddress(address);

      ELoaders.successSnackBar(
          title: 'Congratulations', message: 'Address saved successfully');

      refreshData.toggle();

      resetFormFields();
      Navigator.of(Get.context!).pop();
    } catch (e) {
      ELoaders.erroSnackBar(
          title: 'Error adding Address', message: e.toString());
    }
  }

  void resetFormFields() {
    name.clear();
    phoneNmber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    country.clear();
    addressFormkey.currentState?.reset();
  }
}
