import 'package:flutter/material.dart';
import '../core/constants/colors.dart';
import '../models/cart_model.dart';
import '../utils/helpers.dart';

class CartItemTile extends StatelessWidget {
  final CartItem item;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const CartItemTile({super.key, required this.item, required this.onAdd, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(item.product.imageUrl, width: 72, height: 72, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.product.name, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text('Size: ${item.size}', style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                const SizedBox(height: 6),
                Text(Helpers.formatPrice(item.total), style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w800)),
              ],
            ),
          ),
          Column(
            children: [
              IconButton(onPressed: onAdd, icon: const Icon(Icons.add_circle, color: AppColors.primary)),
              Text('${item.quantity}', style: const TextStyle(color: AppColors.textPrimary)),
              IconButton(onPressed: onRemove, icon: const Icon(Icons.remove_circle_outline, color: AppColors.textSecondary)),
            ],
          ),
        ],
      ),
    );
  }
}
