import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String id;
  String name;
  String image;
  bool? isFeatured;
  int? productCount;

  BrandModel({
    required this.id,
    required this.image,
    required this.name,
    this.isFeatured,
    this.productCount,
  });

  //Empty Helper Function
  static BrandModel empty() => BrandModel(id: '', image: '', name: '');

  //convert model to Json structure so that you can store the data in firestore
  toJson() {
    return {
      'Id': id,
      'Name': name,
      'Image': image,
      'ProductCount': productCount,
      'IsFeatured': isFeatured,
    };
  }

  //Map json oriented document snapshot from Firebase to Usermodel
  factory BrandModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return BrandModel.empty();
    return BrandModel(
      id: data['Id'] ?? '',
      image: data['Image'] ?? '',
      name: data['Name'] ?? '',
      isFeatured: data['IsFeatured'] ?? false,
      productCount: data['ProductCount'] ?? 0,
    );
  }
  factory BrandModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      return BrandModel(
        id: document.id,
        image: document['Image'] ?? '',
        name: document['Name'] ?? '',
        isFeatured: document['IsFeatured'] ?? false,
        productCount: document['ProductCount'] ?? 0,
      );
    } else {
      return BrandModel.empty();
    }
  }
}
