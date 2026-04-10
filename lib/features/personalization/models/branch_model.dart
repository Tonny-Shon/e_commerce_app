import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/features/personalization/models/address_model.dart';

class BranchModel {
  String id;
  final String name;
  final List<AddressModel> stations;

  BranchModel({
    required this.id,
    required this.name,
    this.stations = const [],
  });

  static BranchModel empty() => BranchModel(id: '', name: '', stations: []);

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
    };
  }

  factory BranchModel.fromDocumentSnapshot(DocumentSnapshot snapshot){
    final data = snapshot.data() as Map<String, dynamic>;

    return BranchModel(id: snapshot.id, name: data['Name'] ?? '',);
  }
}
