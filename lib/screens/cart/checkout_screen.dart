import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/colors.dart';
import '../../models/cart_model.dart';
import '../../providers/cart_provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _address = '216 St Paul\'s Rd, London N1 2LL, UK';
  String _contact = '+44-764232';

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final shipping = cart.items.isEmpty ? 0.0 : 299.0;
    final total = cart.total + shipping;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Checkout',
            style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w700)),
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
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [

                      // ── Delivery Address ─────────────────────────
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.card,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.location_on_outlined, color: AppColors.primary, size: 20),
                                const SizedBox(width: 8),
                                const Text('Delivery Address',
                                    style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w700, fontSize: 15)),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () => _showEditAddress(context),
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withValues(alpha: 0.12),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(Icons.edit_outlined, color: AppColors.primary, size: 16),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            const Divider(color: AppColors.border, height: 1),
                            const SizedBox(height: 12),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('Address :', style: TextStyle(color: AppColors.hint, fontSize: 12)),
                                      const SizedBox(height: 4),
                                      Text(_address, style: const TextStyle(color: AppColors.textPrimary, fontSize: 13, height: 1.4)),
                                      const SizedBox(height: 8),
                                      const Text('Contact :', style: TextStyle(color: AppColors.hint, fontSize: 12)),
                                      const SizedBox(height: 4),
                                      Text(_contact, style: const TextStyle(color: AppColors.textPrimary, fontSize: 13)),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 36, height: 36,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: AppColors.primary, width: 1.5),
                                  ),
                                  child: const Icon(Icons.add, color: AppColors.primary, size: 20),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // ── Shop List ────────────────────────────────
                      Row(
                        children: [
                          const Icon(Icons.shopping_bag_outlined, color: AppColors.primary, size: 18),
                          const SizedBox(width: 8),
                          const Text('Shop List',
                              style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w700, fontSize: 15)),
                          const Spacer(),
                          Text('${cart.items.length} items', style: const TextStyle(color: AppColors.hint, fontSize: 13)),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Product Cards
                      ...cart.items.map((item) {
                        final discount = (((item.product.oldPrice - item.product.price) / item.product.oldPrice) * 100).toStringAsFixed(0);
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: AppColors.card,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Image
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: SizedBox(
                                        width: 90, height: 110,
                                        child: Image.asset(
                                          item.product.imageUrl,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) => Container(
                                            color: AppColors.border,
                                            child: const Icon(Icons.image_not_supported, color: AppColors.hint),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(item.product.name,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: AppColors.textPrimary,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14)),
                                          const SizedBox(height: 6),
                                          // Size chip
                                          Row(
                                            children: [
                                              const Text('Size: ', style: TextStyle(color: AppColors.hint, fontSize: 12)),
                                              Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                                decoration: BoxDecoration(
                                                  color: AppColors.primary.withValues(alpha: 0.15),
                                                  borderRadius: BorderRadius.circular(6),
                                                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.4)),
                                                ),
                                                child: Text(item.size,
                                                    style: const TextStyle(
                                                        color: AppColors.primary, fontSize: 11, fontWeight: FontWeight.w600)),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 6),
                                          // Stars
                                          Row(
                                            children: [
                                              ...List.generate(5, (j) => Icon(
                                                    j < item.product.rating.floor()
                                                        ? Icons.star_rounded
                                                        : Icons.star_outline_rounded,
                                                    color: AppColors.primary, size: 14)),
                                              const SizedBox(width: 4),
                                              Text('${item.product.rating}',
                                                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          // Price
                                          Row(
                                            children: [
                                              Text('Rs. ${item.product.price.toStringAsFixed(0)}',
                                                  style: const TextStyle(
                                                      color: AppColors.primary, fontWeight: FontWeight.w800, fontSize: 16)),
                                              const SizedBox(width: 8),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                                    decoration: BoxDecoration(
                                                      color: AppColors.danger.withValues(alpha: 0.15),
                                                      borderRadius: BorderRadius.circular(4),
                                                    ),
                                                    child: Text('save $discount%',
                                                        style: const TextStyle(
                                                            color: AppColors.danger, fontSize: 9, fontWeight: FontWeight.w700)),
                                                  ),
                                                  Text('Rs. ${item.product.oldPrice.toStringAsFixed(0)}',
                                                      style: const TextStyle(
                                                          color: AppColors.hint, fontSize: 11,
                                                          decoration: TextDecoration.lineThrough)),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          // Qty controls
                                          Row(
                                            children: [
                                              const Text('Qty:', style: TextStyle(color: AppColors.hint, fontSize: 12)),
                                              const SizedBox(width: 8),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: AppColors.background,
                                                  borderRadius: BorderRadius.circular(8),
                                                  border: Border.all(color: AppColors.border),
                                                ),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    InkWell(
                                                      onTap: () => cart.decrease(item),
                                                      child: const Padding(
                                                        padding: EdgeInsets.all(4),
                                                        child: Icon(Icons.remove, color: AppColors.textPrimary, size: 14),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                                      child: Text('${item.quantity}',
                                                          style: const TextStyle(
                                                              color: AppColors.textPrimary, fontWeight: FontWeight.w700)),
                                                    ),
                                                    InkWell(
                                                      onTap: () => cart.increase(item),
                                                      child: const Padding(
                                                        padding: EdgeInsets.all(4),
                                                        child: Icon(Icons.add, color: AppColors.primary, size: 14),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Spacer(),
                                              GestureDetector(
                                                onTap: () => cart.decrease(CartItem(
                                                    product: item.product,
                                                    size: item.size,
                                                    quantity: item.quantity)),
                                                child: const Icon(Icons.delete_outline, color: AppColors.danger, size: 20),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Per-item total footer
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                decoration: const BoxDecoration(
                                  color: AppColors.background,
                                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Total Order (${item.quantity}) :',
                                        style: const TextStyle(color: AppColors.hint, fontSize: 13)),
                                    Text('Rs. ${item.total.toStringAsFixed(0)}',
                                        style: const TextStyle(
                                            color: AppColors.textPrimary, fontWeight: FontWeight.w700, fontSize: 14)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),

                // ── Bottom Summary ───────────────────────────────
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                    border: const Border(top: BorderSide(color: AppColors.border)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 16,
                          offset: const Offset(0, -4)),
                    ],
                  ),
                  child: Column(
                    children: [
                      _summaryRow('Subtotal', 'Rs. ${cart.total.toStringAsFixed(0)}'),
                      const SizedBox(height: 6),
                      _summaryRow('Shipping Fee', 'Rs. ${shipping.toStringAsFixed(0)}'),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Divider(color: AppColors.border, height: 1),
                      ),
                      _summaryRow('Total Payment', 'Rs. ${total.toStringAsFixed(0)}', isTotal: true),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                          onPressed: () => Navigator.pushNamed(context, '/placeorder'),
                          child: const Text('Continue to Place Order',
                              style: TextStyle(
                                  color: AppColors.background,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _summaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
                color: isTotal ? AppColors.textPrimary : AppColors.hint,
                fontWeight: isTotal ? FontWeight.w700 : FontWeight.w400,
                fontSize: isTotal ? 15 : 13)),
        Text(value,
            style: TextStyle(
                color: isTotal ? AppColors.primary : AppColors.textPrimary,
                fontWeight: FontWeight.w700,
                fontSize: isTotal ? 18 : 14)),
      ],
    );
  }

  void _showEditAddress(BuildContext context) {
    final addrCtrl = TextEditingController(text: _address);
    final phoneCtrl = TextEditingController(text: _contact);
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.card,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.fromLTRB(
            20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Edit Delivery Address',
                style: TextStyle(
                    color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 16),
            _buildField(addrCtrl, 'Address'),
            const SizedBox(height: 12),
            _buildField(phoneCtrl, 'Contact'),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity, height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: () {
                  setState(() {
                    _address = addrCtrl.text;
                    _contact = phoneCtrl.text;
                  });
                  Navigator.pop(context);
                },
                child: const Text('Save Address',
                    style: TextStyle(color: AppColors.background, fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(TextEditingController ctrl, String label) {
    return TextField(
      controller: ctrl,
      style: const TextStyle(color: AppColors.textPrimary),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.hint),
        filled: true,
        fillColor: AppColors.background,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.border)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.border)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
      ),
    );
  }
}