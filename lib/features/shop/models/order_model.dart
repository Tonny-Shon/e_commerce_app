import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/features/shop/models/cart_item_model.dart';
import 'package:e_commerce_app/utils/constants/enums.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';

import '../../personalization/models/address_model.dart';

class OrderModel {
  final String id;
  final String userId;
  final OrderStatus status;
  final double totalAmout;
  final DateTime orderDate;
  final String paymentMethod;
  final AddressModel? address;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;

  OrderModel({
    required this.id,
    this.userId = '',
    required this.status,
    required this.items,
    this.address,
    required this.totalAmout,
    required this.orderDate,
    this.paymentMethod = 'Airtel',
    this.deliveryDate,
  });

  String get formattedOrderDate => EHelperFunctions.getFormattedDate(orderDate);

  String get formattedDeliveryDate => deliveryDate != null
      ? EHelperFunctions.getFormattedDate(deliveryDate!)
      : '';

  String get orderStatusText => status == OrderStatus.delivered
      ? 'Delivered'
      : status == OrderStatus.shipped
          ? 'Shipment on the way'
          : 'Processing';

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'UserId': userId,
      'Status': status.toString(),
      'TotalAmount': totalAmout,
      'OrderDate': orderDate,
      'PaymentMethod': paymentMethod,
      'Adress': address!.toJson(),
      'DeliveryDate': deliveryDate,
      'Items': items.map((item) => item.toJson()).toList(),
    };
  }

  factory OrderModel.fromSnapshot(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;

    return OrderModel(
        id: data['Id'] as String,
        address: AddressModel.fromMap(data['Address'] as Map<String, dynamic>),
        deliveryDate: data['DeliveryDate'] == null
            ? null
            : (data['DeliveryDate'] as Timestamp).toDate(),
        status: OrderStatus.values
            .firstWhere((e) => e.toString() == data['Status']),
        items: (data['Items'] as List<dynamic>)
            .map((itemData) =>
                CartItemModel.fromJson(itemData as Map<String, dynamic>))
            .toList(),
        totalAmout: data['TotalAmount'] as double,
        orderDate: (data['OrderDate'] as Timestamp).toDate());
  }
}
