import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebViewController extends GetxController{
  final String redirectUrl;
  late final WebViewController webViewController;

  final RxBool isLoading = true.obs;

  PaymentWebViewController(this.redirectUrl);

  @override
  void onInit() {
    super.onInit();
    _initializeWebView();
  }

  void _initializeWebView(){
    webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(Colors.transparent)
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress){
          // isLoading.value = progress < 100;
        },
        onPageStarted: (String url){
          isLoading.value = true;
        },
        onPageFinished: (String url){
          isLoading.value = false;
        },
        onWebResourceError: (WebResourceError error){
          // print('WebView Error: ${error.errorCode} - ${error.description}');
            isLoading.value = false;
          // isLoading.value = false;
          // Get.snackbar('Error', 'Failed to load payment page. Please try again.');
          // Get.back();
        },
        onNavigationRequest: (NavigationRequest request){
          //Handle deep link callback
          if(request.url.startsWith('myapp://payment')){
            Get.back(); // Close the WebView
              // print("Payment completed via callback");
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        
      ),
    )
    ..loadRequest(Uri.parse(redirectUrl));
  }

  //Optional: Method to reload the page
  void reload(){
    webViewController.reload();
  }
}