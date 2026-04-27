import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../core/constants/colors.dart';
import '../../models/product_model.dart';
import '../../providers/cart_provider.dart';
import '../../providers/wishlist_provider.dart';
import '../../widgets/custom_button.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel product;
  const ProductDetailsScreen({super.key, required this.product});
  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String? _selectedSize;
  int _qty = 1;

  void _addToCart() {
    if (_selectedSize == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a size'),
            backgroundColor: AppColors.danger, behavior: SnackBarBehavior.floating));
      return;
    }
    context.read<CartProvider>().addToCart(widget.product, _selectedSize!);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(children: [
          const Icon(Icons.check_circle, color: AppColors.success),
          const SizedBox(width: 8),
          Expanded(child: Text('${widget.product.name} added to cart!')),
        ]),
        backgroundColor: AppColors.card,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) Navigator.pushNamed(context, '/checkout');
    });
  }

  void _buyNow() {
    if (_selectedSize == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a size'),
            backgroundColor: AppColors.danger, behavior: SnackBarBehavior.floating));
      return;
    }
    context.read<CartProvider>().addToCart(widget.product, _selectedSize!);
    Navigator.pushNamed(context, '/checkout');
  }

  // Share product — copies link to clipboard + shows snackbar
  void _share() {
    final p = widget.product;
    final text =
        '🛍️ Check out ${p.name} on Velura!\n'
        'Category: ${p.category}\n'
        'Price: Rs. ${p.price.toStringAsFixed(0)}\n'
        'Rating: ⭐ ${p.rating}/5\n\n'
        'Download Velura app to explore luxury fashion!';

    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(children: [
          Icon(Icons.share, color: AppColors.primary),
          SizedBox(width: 8),
          Text('Product details copied to clipboard!'),
        ]),
        backgroundColor: AppColors.card,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    final discount = (((p.oldPrice - p.price) / p.oldPrice) * 100).toStringAsFixed(0);
    final wishlist = context.watch<WishlistProvider>();
    final isFav = wishlist.isFav(p.id);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background, elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          // ❤️ Favourite toggle
          IconButton(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                key: ValueKey(isFav),
                color: isFav ? AppColors.danger : AppColors.textPrimary,
              ),
            ),
            onPressed: () {
              wishlist.toggle(p);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(children: [
                    Icon(isFav ? Icons.favorite_border : Icons.favorite,
                        color: AppColors.danger),
                    const SizedBox(width: 8),
                    Text(isFav
                        ? '${p.name} removed from wishlist'
                        : '${p.name} added to wishlist!'),
                  ]),
                  backgroundColor: AppColors.card,
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              );
            },
          ),
          // 🔗 Share
          IconButton(
            icon: const Icon(Icons.share_outlined, color: AppColors.textPrimary),
            onPressed: _share,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
              child: SizedBox(
                height: 360, width: double.infinity,
                child: Image.asset(p.imageUrl, fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(color: AppColors.card,
                        child: const Center(child: Icon(Icons.image_not_supported,
                            color: AppColors.hint, size: 60)))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.primary.withValues(alpha: 0.4)),
                        ),
                        child: Text(p.category,
                            style: const TextStyle(color: AppColors.primary, fontSize: 12,
                                fontWeight: FontWeight.w600, letterSpacing: 1.2)),
                      ),
                      Row(children: [
                        const Icon(Icons.star_rounded, color: AppColors.primary, size: 18),
                        const SizedBox(width: 4),
                        Text('${p.rating}',
                            style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w700)),
                        const Text(' (128)', style: TextStyle(color: AppColors.hint, fontSize: 12)),
                      ]),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(p.name,
                      style: const TextStyle(color: AppColors.textPrimary,
                          fontSize: 22, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 12),
                  Row(children: [
                    Text('Rs. ${p.price.toStringAsFixed(0)}',
                        style: const TextStyle(color: AppColors.primary,
                            fontSize: 24, fontWeight: FontWeight.w800)),
                    const SizedBox(width: 12),
                    Text('Rs. ${p.oldPrice.toStringAsFixed(0)}',
                        style: const TextStyle(color: AppColors.hint, fontSize: 16,
                            decoration: TextDecoration.lineThrough)),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.danger.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text('-$discount%',
                          style: const TextStyle(color: AppColors.danger,
                              fontSize: 12, fontWeight: FontWeight.w700)),
                    ),
                  ]),
                  const SizedBox(height: 20),
                  const Text('Description',
                      style: TextStyle(color: AppColors.textPrimary,
                          fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Text(p.description,
                      style: const TextStyle(color: AppColors.textSecondary, height: 1.6)),
                  const SizedBox(height: 24),
                  const Text('Select Size',
                      style: TextStyle(color: AppColors.textPrimary,
                          fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10, runSpacing: 10,
                    children: p.sizes.map((size) {
                      final sel = _selectedSize == size;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedSize = size),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 52, height: 44,
                          decoration: BoxDecoration(
                            color: sel ? AppColors.primary : AppColors.card,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: sel ? AppColors.primary : AppColors.border,
                                width: sel ? 2 : 1),
                          ),
                          child: Center(child: Text(size,
                              style: TextStyle(
                                  color: sel ? AppColors.background : AppColors.textSecondary,
                                  fontWeight: FontWeight.w600, fontSize: 12))),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      const Text('Quantity',
                          style: TextStyle(color: AppColors.textPrimary,
                              fontSize: 18, fontWeight: FontWeight.w600)),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.card,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Row(children: [
                          IconButton(
                            icon: const Icon(Icons.remove, color: AppColors.textPrimary, size: 18),
                            onPressed: () { if (_qty > 1) setState(() => _qty--); },
                          ),
                          Text('$_qty',
                              style: const TextStyle(color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w700, fontSize: 16)),
                          IconButton(
                            icon: const Icon(Icons.add, color: AppColors.primary, size: 18),
                            onPressed: () => setState(() => _qty++),
                          ),
                        ]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Row(children: [
                    Expanded(child: CustomButton(
                        label: 'Add to Cart', outline: true, onPressed: _addToCart)),
                    const SizedBox(width: 12),
                    Expanded(child: CustomButton(label: 'Buy Now', onPressed: _buyNow)),
                  ]),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}