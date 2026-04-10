import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/success_screen/success_screen.dart';
import '../../../../../../images/images.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../../../../utils/popups/loaders.dart';
import '../controllers/order_controller.dart';
import '../controllers/payment_inappwebview_controller.dart';

class PaymentWebViewScreen extends StatelessWidget {
  final String redirectUrl;
  final String? trackingId;
  final double totalAmount;

  const PaymentWebViewScreen({
    super.key,
    required this.redirectUrl,
    this.trackingId,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaymentInAppWebViewController(redirectUrl));

    final dark = EHelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Complete Payment',
            style: TextStyle(color: dark ? Colors.white : Colors.black)),
        // backgroundColor: dark ? Colors.black : Colors.white,
        // foregroundColor: dark ? Colors.white : Colors.black,
        leading: IconButton(
          icon: Icon(Icons.close, color: dark ? Colors.white : Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(
        () => Stack(
          children: [
            InAppWebView(
  initialUrlRequest: URLRequest(url: WebUri(redirectUrl)),
  initialSettings: InAppWebViewSettings(
    javaScriptEnabled: true,
    useShouldOverrideUrlLoading: true,
    supportZoom: false,
   
  ),
  onWebViewCreated: (InAppWebViewController webviewcontroller) {
    controller.webViewController = webviewcontroller;
  },
  onLoadStart: (InAppWebViewController webviewcontroller, url) {
    controller.isLoading.value = true;
  },
  onLoadStop: (InAppWebViewController webviewcontroller, url) {
    controller.isLoading.value = false;
  },
  onReceivedError: (InAppWebViewController webviewcontroller, request, error) {  // ✅ updated
    // print("WebView Load Error: ${error.errorCode} - ${error.description}");
    controller.isLoading.value = false;
  },
  onReceivedServerTrustAuthRequest: (controller, challenge) async {
    return ServerTrustAuthResponse(
      action: ServerTrustAuthResponseAction.PROCEED,
    );
  },
  shouldOverrideUrlLoading: (controller, navigationAction) async {
    final uri = navigationAction.request.url?.toString() ?? '';
    if (uri.startsWith('myapp://payment/complete') ||
        uri.contains('success') ||
        uri.contains('completed')) {
      Get.back();
      _handleSuccessfulPayment();
      return NavigationActionPolicy.CANCEL;
    }
    return NavigationActionPolicy.ALLOW;
  },
),

            // Loading Indicator
            if (controller.isLoading.value)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }

  void _handleSuccessfulPayment() {
    ELoaders.successSnackBar(
      title: "Payment Successful",
      message: "Thank you! Your order is being processed.",
    );

    // Process order
    final orderController = Get.find<OrderController>();
    orderController.processOrder(totalAmount);

    // Go to success / order confirmation screen
    Get.offAll(() => const SuccessScreen(
          image: EImages.successfulPayment,
          title: 'Payment Successful',
          subTitle: 'Your order has been placed successfully.',
        ));
  }
}
