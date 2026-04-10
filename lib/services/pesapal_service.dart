// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:http/http.dart' as http;

// class PesapalService {

//   static const String backendUrl = "http://10.0.2.2:3000/api";

//   static const String _sandboxBaseUrl = "https://cybqa.pesapal.com/pesapalv3";
//   static const String _liveBaseUrl = "https://pay.pesapal.com/v3";

//   // static const String baseUrl = 'https://cybqa.pesapal.com/pesapalv3';
//   static String get _baseUrl {
//     final env = dotenv.env['PESAPAL_ENVIRONMENT'] ?? 'sandbox';
//     return env == 'live' ? _liveBaseUrl : _sandboxBaseUrl;
//   }

//   static String? get _consumerKey => dotenv.env['PESAPAL_CONSUMER_KEY'];
//   static String? get _consumerSecret => dotenv.env['PESAPAL_CONSUMER_SECRET'];

//   String? _cachedToken;
//   DateTime? _tokenExpiry;

//   Future<String> _getAccessToken() async {
//     if (_cachedToken != null &&
//         _tokenExpiry != null &&
//         DateTime.now().isBefore(_tokenExpiry!)) {
//       return _cachedToken!;
//     }

//     if (_consumerKey == null || _consumerSecret == null) {
//       throw const PesaPalException(
//           'Pesapal credentials are not set in .env file');
//     }

//     final url = Uri.parse('$_baseUrl/api/Auth/RequestToken');

//     try {
//       final response = await http.post(
//         url,
//         headers: {
//           "Content-Type": "application/json",
//           "Accept": "application/json",
//         },
//         body: jsonEncode({
//           "consumer_key": _consumerKey,
//           "consumer_secret": _consumerSecret,
//         }),
//       );

//       // ADD THIS DEBUG LINE:
//       // print("Pesapal Auth Status: ${response.statusCode}");
//       // print("Pesapal Auth Body: '${response.body}'");

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final token = data['token'] as String?;
//         final expiryMinutes = (data['expiry'] as int?) ?? 300;

//         if (token == null || token.isEmpty) {
//           throw const PesaPalException('No token returned from Pesapal');
//         }
//         _cachedToken = token;
//         _tokenExpiry = DateTime.now().add(Duration(minutes: expiryMinutes - 1));
//         return token;
//       } else {
//         throw PesaPalException(
//             "Token request failed: ${response.statusCode} - ${response.body}");
//       }
//     } catch (e) {
//       if (e is PesaPalException) rethrow;
//       throw PesaPalException("Network error getting token: $e");
//     }
//   }


//   /// Poll status every 10s(upto 3min) - call after opening redirect
//   // void _pollTransactionStatus({
//   //   required String orderTrackingId,
//   //   int maxAttempts = 18,
//   //   required Function(String trackingId, String status) onSuccess,
//   //   required Function(String message) onError,
//   // }) {
//   //   int attempts = 0;
//   //   Timer.periodic(const Duration(seconds: 10), (timer) async {
//   //     attempts++;
//   //     if (attempts > maxAttempts) {
//   //       timer.cancel();
//   //       onError("Payment timeout - check status manually");
//   //       return;
//   //     }
//   //     try {
//   //       final token = await _getAccessToken();
//   //       final url = Uri.parse(
//   //         "$_baseUrl/Transactions/GetTransactionStatus?orderTrackingId=$orderTrackingId",
//   //       );
//   //       final response = await http.get(
//   //         url,
//   //         headers: {"Authorization": "Bearer $token"},
//   //       );

//   //       if (response.statusCode == 200) {
//   //         final data = jsonDecode(response.body);
//   //         final status =
//   //             data['payment_status_description'] as String? ?? "PENDING";

//   //         if (status == "Completed" || status == "Successful") {
//   //           timer.cancel();
//   //           onSuccess(orderTrackingId, status);
//   //         } else if (status == "Failed" || status == "Cancelled") {
//   //           timer.cancel();
//   //           onError("Payment $status: ${data['message'] ?? 'No details'}");
//   //         }
//   //       }
//   //     } catch (e) {
//   //       //silent retry on poll error
//   //     }
//   //   });
//   // }
// }

// class PesaPalException implements Exception {
//   final String message;
//   const PesaPalException(this.message);

//   @override
//   String toString() => message;
// }
