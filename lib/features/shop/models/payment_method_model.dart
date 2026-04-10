class PaymentMethodModel {
  String id;
  String name;
  String image;

  PaymentMethodModel({required this.id,required this.name, required this.image});

  static PaymentMethodModel empty() => PaymentMethodModel(id: '',name: '', image: '');
}
