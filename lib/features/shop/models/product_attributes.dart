class ProductAttributesModel {
  String? name;
  final List<String>? values;

  ProductAttributesModel({this.name, this.values});

  //Json Format
  toJson() {
    return {'Name': name, 'Values': values};
  }

  //Map Json oriented document snapshot from firebase to Model
  factory ProductAttributesModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return ProductAttributesModel();
    return ProductAttributesModel(
      name: data.containsKey('Name') ? data['Name'] : '',
      values: List<String>.from(data['Values']),
    );
  }
}
