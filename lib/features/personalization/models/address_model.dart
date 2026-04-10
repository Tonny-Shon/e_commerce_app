import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  String id;
  final String name;
  final double shippingAmount;

  AddressModel({
    required this.id,
    required this.name,
    required this.shippingAmount,
  });

  static AddressModel empty() =>
      AddressModel(id: '', name: '', shippingAmount: 0.0);

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'ShippingAmount': shippingAmount,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> data) {
    return AddressModel(
      id: data['Id'] as String,
      name: data['Name'] as String,
      shippingAmount: data['ShippingAmount'] is int
          ? (data['ShippingAmount'] as int).toDouble()
          : data['ShippingAmount'] is String
              ? double.parse(data['ShippingAmount'] as String)
              : data['ShippingAmount'] ?? 0.0,
    );
  }

  factory AddressModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return AddressModel(
      id: snapshot.id,
      name: data['Name'] ?? '',
      shippingAmount: data['ShippingAmount'] is int
          ? (data['ShippingAmount'] as int).toDouble()
          : data['ShippingAmount'] is String
              ? double.parse(data['ShippingAmount'] as String)
              : data['ShippingAmount'] ?? 0.0,
    );
  }
  @override
  String toString() {
    return '$id, $name, $shippingAmount';
  }
}


