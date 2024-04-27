class Product {
  final String id;
  final String name;
  final String price;
  final String salePrice;
  final String imagePath;
  final int? Rating;
  final List<dynamic>? comment;
  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.salePrice,
    required this.imagePath,
    this.Rating,
    this.comment,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      imagePath: map['imagePath'],
      salePrice: map['salePrice'],
      Rating: map['Rating'],
      comment: map['comment'],
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
      'Rating': 0,
      'like': [],
      'comment': [],
    };
  }

  static fromJson(data) {}
}
