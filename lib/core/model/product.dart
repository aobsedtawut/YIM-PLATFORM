class Product {
  final int id;
  final String name;
  final String imageUrl;
  final double price;
  final bool isFavorite;

  Product({
    this.isFavorite = false,
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
  });
  Product copyWith({
    int? id,
    String? name,
    String? imageUrl,
    double? price,
    bool? isFavorite,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
      isFavorite: json['is_favorite'] ?? false,
      price: json['price'].toDouble(),
    );
  }
}
