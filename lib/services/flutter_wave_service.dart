// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:uuid/uuid.dart';

// class FlutterWaveService {
//   static const String baseUrl = 'https://developersandbox-api.flutterwave.com';
//   static const String oauthUrl = 'https://idp.flutterwave.com/realms/flutterwave/protocol/openid-connect/token';

//   static const String clientId = 'b50a0c57-73fb-4099-8037-b17f9a2d9532';
//   static const String clientSecret = '0dwt6dk3YBRLZMVBC8gbdTEI3AOZPPPc';

//   String? _accessToken;
//   DateTime? _tokenExpiry;

//   Future<String> getAccessToken() async{
//     // Return cached token if still valid (with 60s buffer)
//     if(_accessToken != null && _tokenExpiry 
//     != null && DateTime.now().isBefore(_tokenExpiry!.subtract(const Duration(seconds: 60)))){
//       return _accessToken!;
//     }
//     try{
//       final response = await http.post(
//         Uri.parse(oauthUrl),
//         headers: {
//           'Content-Type': 'application/x-www-form-urlencoded'
//         },
//         body: {
//           'grant_type': 'client_credentials',
//           'client_id': clientId,
//           'client_secret': clientSecret,
//         },
//       );

//       print('OAuth Status: ${response.statusCode}');           // ← Add this
//       print('OAuth Body: ${response.body}');

//       if(response.statusCode == 200){
//         final data = jsonDecode(response.body);
//         _accessToken = data['access_token'];
//         final expiresIn = data['expires_in'] as int; // typically 600 seconds
//         _tokenExpiry = DateTime.now().add(Duration(seconds: expiresIn));
//         return _accessToken!;
//       }else{
//         throw Exception('OAuth failed: ${response.statusCode} - ${response.body}');
//       }
//     }catch(e){
//       rethrow;
//     }
//   }

// // ... (Your class definition)
// Future<Map<String, dynamic>> initiateMobileMoneyPayment({
//   required String email,
//   required String phone,
//   required String network,
//   required double amount,
// }) async {
//   final token = await getAccessToken();
//   final headers = {
//     'Authorization': 'Bearer $token',
//     'Content-Type': 'application/json',
//     'X-Trace-Id': const Uuid().v4(),
//     'X-Idempotency-Key': const Uuid().v4(),
//     'X-Scenario-Key': 'scenario:auth_3ds&issuer:approved',
//   };

//   // --- 1. Create Customer ---
//   final customerRes = await http.post(
//     Uri.parse('$baseUrl/customers'),
//     headers: headers,
//     body: jsonEncode({
//       'email': email.trim(),
//       'phone': {'country_code': '256', 'number': phone},
//       'name': {'first': 'Guest', 'last': 'Customer'}
//     })
//   );

//   String customerId;

//   // HANDLE STATUS CODES HERE
//   if (customerRes.statusCode == 201 || customerRes.statusCode == 200) {
//     customerId = jsonDecode(customerRes.body)['data']['id'];
//   } else if (customerRes.statusCode == 409) {
//     print("Customer exists, searching for ID...");
//     // You must implement this helper or the ID will be null
//     customerId = await _findExistingCustomerId(email.trim(), headers);
//   } else {
//     // ONLY throw if it's not a 200, 201, or 409
//     throw Exception('Customer creation failed: ${customerRes.body}');
//   }

//   // --- 2. Create Payment method ---
//   final pmRes = await http.post(
//     Uri.parse('$baseUrl/payment-methods'),
//     headers: headers,
//     body: jsonEncode({
//       'type': 'mobile_money',
//       'mobile_money': {
//         'country_code': '256',
//         'network': network.toLowerCase().trim(),
//         'phone_number': '785404880'
//       }
//     })
//   );

//   if (pmRes.statusCode != 201 && pmRes.statusCode != 200) {
//     throw Exception('Payment method failed: ${pmRes.body}');
//   }

//   final paymentMethodId = jsonDecode(pmRes.body)['data']['id'];

//   // --- 3. Initiate charge ---
//   final alphanumericReference = const Uuid().v4().replaceAll('-', '');

//   final chargeRes = await http.post(
//     Uri.parse('$baseUrl/charges'),
//     headers: headers,
//     body: jsonEncode({
//       'amount': amount,
//       'currency': 'UGX',
//       'customer_id': customerId,
//       'payment_method_id': paymentMethodId,
//       'reference': alphanumericReference,
//     })
//   );

//   if (chargeRes.statusCode != 201 && chargeRes.statusCode != 200) {
//     throw Exception('Charge failed: ${chargeRes.body}');
//   }

//   return jsonDecode(chargeRes.body);
// }

// // HELPER FUNCTION: You need this to handle the 409 case!
// Future<String> _findExistingCustomerId(String email, Map<String, String> headers) async {
//   final response = await http.get(
//     Uri.parse('$baseUrl/customers?email=$email'),
//     headers: headers,
//   );

//   if (response.statusCode == 200) {
//     final List data = jsonDecode(response.body)['data'];
//     if (data.isNotEmpty) {
//       return data.first['id'];
//     }
//   }
//   throw Exception("Customer exists but could not retrieve ID");
// }

//   Future<String> checkChargeStatus(String chargeId, String accessToken) async {
//   // You already have 'accessToken' passed in, 
//   // but calling getAccessToken() again is fine for safety.
//   final token = await getAccessToken(); 
  
//   final headers = {
//     'Authorization': 'Bearer $token',
//     'Content-Type': 'application/json',
//   };

//   final res = await http.get(
//     Uri.parse('$baseUrl/charges/$chargeId'),
//     headers: headers,
//   );

//   if (res.statusCode == 200) {
//     final responseData = jsonDecode(res.body);
    
//     // CRITICAL FIX: Look inside the ['data'] object for the payment status
//     // Top-level ['st atus'] is just 'success' for the HTTP request.
//     // Inner ['data']['status'] is 'succeeded', 'pending', or 'failed'.
//     return responseData['data']['status']; 
//   } else {
//     print("Check Status Error: ${res.body}");
//     throw Exception('Status check failed: ${res.body}');
//   }
// }
// }