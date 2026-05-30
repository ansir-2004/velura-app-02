class ProductModel {
  final String id;
  final String name;
  final String category;
  final String description;
  final String imageUrl;
  final double price;
  final double oldPrice;
  final double rating;
  final List<String> sizes;

  const ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.oldPrice,
    required this.rating,
    required this.sizes,
  });

  factory ProductModel.fromFirestore(Map<String, dynamic> data, String id) {
    return ProductModel(
      id: id,
      name: data['name'] ?? '',
      category: data['category'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
      oldPrice: (data['oldPrice'] as num?)?.toDouble() ?? 0.0,
      rating: (data['rating'] as num?)?.toDouble() ?? 0.0,
      sizes: List<String>.from(data['sizes'] ?? []),
    );
  }
}

