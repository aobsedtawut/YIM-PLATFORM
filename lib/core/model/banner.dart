class Banner {
  final int id;
  final String imageUrl;

  Banner({
    required this.id,
    required this.imageUrl,
  });
  Banner copyWith({
    int? id,
    String? imageUrl,
  }) {
    return Banner(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  factory Banner.fromJson(Map<String, dynamic> json) {
    return Banner(
      id: json['id'],
      imageUrl: json['image_url'],
    );
  }
}
