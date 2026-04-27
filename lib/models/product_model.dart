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
}
