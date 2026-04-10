import 'package:e_commerce_app/data/repositories/addresses/address_repository.dart';
import 'package:e_commerce_app/features/personalization/models/address_model.dart';
import 'package:e_commerce_app/features/personalization/models/branch_model.dart';
import 'package:e_commerce_app/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  RxBool refreshData = true.obs;

  /// Lists
  RxList<BranchModel> branches = <BranchModel >[].obs;
  RxList<AddressModel> address = <AddressModel>[].obs;

  /// selected
  final Rx<BranchModel> selectedBranch = BranchModel.empty().obs;
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;

  final addressRepository = Get.put(AddressRepository());

   RxBool isLoading = false.obs;

  // final name = TextEditingController();
  // final phoneNmber = TextEditingController();
  GlobalKey<FormState> addressFormkey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchAddresses();
    fetchBranches();
  }

   /// 🔹 Fetch all branches
  Future<void> fetchBranches() async {
    try {
      isLoading.value = true;

      final snapshot = await addressRepository.getBranches();

      branches.value = snapshot;

    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchStations(String branchId) async{
    try{
      isLoading.value = true;

      final snapshot = await addressRepository.getStations(branchId);

      address.value = snapshot;

    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
    
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

  void selectBranch(BranchModel branch) {
    try {
      selectedBranch.value = branch;

      /// Reset station
    selectedAddress.value = AddressModel.empty();

    //Load stations for the selected branch
      fetchStations(branch.id);
    } catch (e) {
      ELoaders.erroSnackBar(title: 'Error in selection', message: e.toString());
    }
  }

  /// When station is selected
  void selectStation(AddressModel station) {
    try {
      selectedAddress.value = station;
    } catch (e) {
      ELoaders.erroSnackBar(title: 'Error in selection', message: e.toString());
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
