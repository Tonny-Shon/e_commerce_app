import 'package:get/get.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PaymentInAppWebViewController extends GetxController {
  final String redirectUrl;
  late InAppWebViewController webViewController;
  final RxBool isLoading = true.obs;

  PaymentInAppWebViewController(this.redirectUrl);

  // Optional: Reload the page
  void reload() {
    webViewController.reload();
  }
}