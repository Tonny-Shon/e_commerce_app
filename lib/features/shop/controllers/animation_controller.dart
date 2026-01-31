import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartAnimationController extends GetxController with GetSingleTickerProviderStateMixin{

static CartAnimationController get instance => Get.find();

late AnimationController controller;
late Animation<double> scaleAnimation;
late Animation<double> rotationAnimation;

final RxBool _isAnimating = false.obs;
bool get isAnimating => _isAnimating.value;

@override
  void onInit() {
    super.onInit();
    controller = AnimationController(vsync: this,
    duration: const Duration(milliseconds: 400)
    );

    scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.8), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 0.8, end: 1.2), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 25),
    ]).animate(CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),);

    rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );
  }

  Future<void> playAddAnimation() async{
    if(_isAnimating.value) return;

    _isAnimating.value = true;
    await controller.forward();
    await controller.reverse();
    _isAnimating.value = false;
  }
  @override
  void onClose() {
    controller.dispose();
    super.onClose();
   

  }
}