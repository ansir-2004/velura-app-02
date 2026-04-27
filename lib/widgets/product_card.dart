import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../core/constants/colors.dart';
import '../utils/helpers.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onTap;

  const ProductCard({super.key, required this.product, required this.onTap});

  Widget _buildImage() {
    final url = product.imageUrl;
    if (url.startsWith('http')) {
      return Image.network(
        url,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _placeholder(),
      );
    } else {
      return Image.asset(
        url,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _placeholder(),
      );
    }
  }

  Widget _placeholder() {
    return Container(
      color: AppColors.border,
      child: const Center(
        child: Icon(Icons.image_not_supported, color: AppColors.hint, size: 40),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                child: _buildImage(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text(product.category, style: const TextStyle(color: AppColors.primary, fontSize: 12)),
                  const SizedBox(height: 6),
                  Text(Helpers.formatPrice(product.price), style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w800)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}