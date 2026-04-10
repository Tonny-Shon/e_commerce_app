import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../screens/login/login.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  //variables
  final pageController = PageController();
  Rx<int> currentIndex = 0.obs;

  //update current index when page scroll
  void updatePageIndicator(index) => currentIndex.value = index;

  // jump to the specific dot selected page
  void dotNavigationClick(index) {
    currentIndex.value = index;
    pageController.jumpTo(index);
  }

  //update current index and jump to next page
  void nextPage() {
    if (currentIndex.value == 2) {
      Get.offAll(() => const LoginScreen());
    } else {
      int page = currentIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  //update current index and jump to the last page
  void skipPage() {
    currentIndex.value = 2;
    pageController.jumpToPage(2);
  }
}
