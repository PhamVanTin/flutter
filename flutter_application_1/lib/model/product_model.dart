class Product {
  final String id;
  final String name;
  final String price;
  final String salePrice;
  final String imagePath;
  final int? Rating;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.salePrice,
    required this.imagePath,
    this.Rating,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      imagePath: map['imagePath'],
      salePrice: map['salePrice'],
      Rating: map['Rating'],
    );
  }

  get quantity => null;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imagePath': imagePath,
      'salePrice': salePrice,
      'Rating': Rating,
      'like': [],
    };
  }

  static fromJson(data) {}
}
