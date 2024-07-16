class CartItemModel {
  String productId;
  String title;
  double price;
  String? image;
  int quantity;
  // String variationId;
  String? brandName;
  Map<String, dynamic>? selectedVariation;

  CartItemModel({
    required this.productId,
    required this.quantity,
    //this.variationId = '',
    this.image,
    this.price = 0.0,
    this.title = '',
    this.brandName,
    this.selectedVariation,
  });

  static CartItemModel empty() => CartItemModel(productId: '', quantity: 0);

  //convert a cartItem to a json map
  Map<String, dynamic> toJson() {
    return {
      'ProductId': productId,
      'Title': title,
      'Price': price,
      'Image': image,
      'Quantity': quantity,
      //'VariationId': variationId,
      'BrandName': brandName,
      'selectedVariation': selectedVariation,
    };
  }

  //create a cart item from a json map
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['ProductId'],
      title: json['Title'],
      price: json['Price']?.toDouble(),
      image: json['Image'],
      quantity: json['Quantity'],
      // variationId: json['VariationId'],
      brandName: json['BrandName'],
      selectedVariation: json['SelectedVariation'] != null
          ? Map<String, dynamic>.from(json['SelectedVariation'])
          : null,
    );
  }
}
