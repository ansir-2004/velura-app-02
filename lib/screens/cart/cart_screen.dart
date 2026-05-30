import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/colors.dart';
import '../../providers/cart_provider.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/product_image.dart';
import '../../utils/helpers.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background, elevation: 0,
        title: const Text('My Cart',
            style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w700)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: cart.items.isEmpty
          ? const Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.shopping_bag_outlined, color: AppColors.hint, size: 72),
                SizedBox(height: 16),
                Text('Your cart is empty',
                    style: TextStyle(color: AppColors.textPrimary, fontSize: 20, fontWeight: FontWeight.w700)),
                SizedBox(height: 8),
                Text('Add products to get started', style: TextStyle(color: AppColors.hint)),
              ]),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: cart.items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, i) {
                      final item = cart.items[i];
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
                              borderRadius: BorderRadius.circular(10),
                              child: SizedBox(
                                width: 70, height: 70,
                                child: ProductImage(
                                  imageUrl: item.product.imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.product.name,
                                      maxLines: 1, overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 4),
                                  Text('Size: ${item.size}',
                                      style: const TextStyle(color: AppColors.hint, fontSize: 12)),
                                  const SizedBox(height: 6),
                                  Text(Helpers.formatPrice(item.product.price),
                                      style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700)),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.delete_outline, color: AppColors.danger, size: 20),
                                  onPressed: () => cart.remove(item),
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () => cart.decrease(item),
                                      child: const Padding(padding: EdgeInsets.all(4),
                                          child: Icon(Icons.remove, color: AppColors.textPrimary, size: 16)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      child: Text('${item.quantity}',
                                          style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w700)),
                                    ),
                                    InkWell(
                                      onTap: () => cart.increase(item),
                                      child: const Padding(padding: EdgeInsets.all(4),
                                          child: Icon(Icons.add, color: AppColors.primary, size: 16)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                    border: const Border(top: BorderSide(color: AppColors.border)),
                  ),
                  child: Column(
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        const Text('Subtotal', style: TextStyle(color: AppColors.hint)),
                        Text(Helpers.formatPrice(cart.subtotal),
                            style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
                      ]),
                      const SizedBox(height: 8),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        const Text('Shipping', style: TextStyle(color: AppColors.hint)),
                        Text(Helpers.formatPrice(cart.shipping),
                            style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
                      ]),
                      const Divider(color: AppColors.border, height: 20),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        const Text('Total',
                            style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w700, fontSize: 16)),
                        Text(Helpers.formatPrice(cart.total),
                            style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w800, fontSize: 18)),
                      ]),
                      const SizedBox(height: 16),
                      CustomButton(
                        label: 'Checkout',
                        onPressed: () => Navigator.pushNamed(context, '/checkout'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
