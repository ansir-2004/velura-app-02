import 'package:flutter/material.dart';

import '../core/constants/colors.dart';

class ProductImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;
  final BorderRadiusGeometry? borderRadius;

  const ProductImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.borderRadius,
  });

  Widget _placeholder() {
    return Container(
      color: AppColors.border,
      child: const Center(
        child: Icon(Icons.image_not_supported, color: AppColors.hint),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final image = imageUrl.startsWith('http')
        ? Image.network(imageUrl, width: width, height: height, fit: fit, errorBuilder: (_, __, ___) => _placeholder())
        : Image.asset(imageUrl, width: width, height: height, fit: fit, errorBuilder: (_, __, ___) => _placeholder());

    if (borderRadius == null) {
      return image;
    }

    return ClipRRect(
      borderRadius: borderRadius!,
      child: image,
    );
  }
}
