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
              onReceivedError:
                  (InAppWebViewController webviewcontroller, request, error) {

                controller.isLoading.value = false;
              },
              onReceivedServerTrustAuthRequest: (controller, challenge) async {
                return ServerTrustAuthResponse(
                  action: ServerTrustAuthResponseAction.PROCEED,
                );
              },
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                final uri = navigationAction.request.url?.toString() ?? '';
                if (uri.startsWith('myapp://payment/complete') ) {
                  Get.back();

                  //Parse query parameters
                  final parsedUri = Uri.parse(uri);
                  final queryParams = parsedUri.queryParameters;

                  //Adjust key names based on your backend's response

                  String? status = queryParams['status'] ?? queryParams['payment_status'] ?? queryParams['status_code'];
                  String? paymentMethod = queryParams['payment_method'] ??
                      queryParams['payment_method_id'] ??
                      queryParams['method'] ??
                      queryParams['payment_method_name'];
                  _handleSuccessfulPayment(status: status, paymentMethod: paymentMethod);
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

  void _handleSuccessfulPayment({String? status,String? paymentMethod}) {
   // Optional: You can check status if Pesapal sends it
  if (status != null && status.toLowerCase() != "success") {
    ELoaders.warningSnackBar(
      title: "Payment Not Confirmed",
      message: "Please check your payment status",
    );
    return;
  }

    // Process order
    final orderController = Get.find<OrderController>();
    orderController.processOrder(totalAmount, paymentMethod: paymentMethod);

    // Go to success / order confirmation screen
    Get.offAll(() => const SuccessScreen(
          image: EImages.successfulPayment,
          title: 'Payment Successful',
          subTitle: 'Your order has been placed successfully.',
        ));
  }
}
