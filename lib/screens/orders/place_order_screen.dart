import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/colors.dart';
import '../../providers/cart_provider.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({super.key});
  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  final _formKey   = GlobalKey<FormState>();
  final _nameCtrl  = TextEditingController();
  final _addrCtrl  = TextEditingController();
  final _phoneCtrl = TextEditingController();
  bool _isPlacing  = false;
  bool _couponApplied = false;
  String _payment  = 'Cash on Delivery';

  @override
  void dispose() {
    _nameCtrl.dispose(); _addrCtrl.dispose(); _phoneCtrl.dispose();
    super.dispose();
  }

  Future<void> _placeOrder() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isPlacing = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isPlacing = false);
    if (!mounted) return;
    context.read<CartProvider>().clear();
    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80, height: 80,
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_circle, color: AppColors.success, size: 48),
            ),
            const SizedBox(height: 20),
            const Text('Order Placed!',
                style: TextStyle(color: AppColors.textPrimary, fontSize: 22, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            const Text('Your order has been placed successfully.\nWe\'ll deliver it soon!',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textSecondary, height: 1.5)),
            const SizedBox(height: 8),
            const Text('#VLR-2024-001',
                style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700)),
            const SizedBox(height: 24),
            CustomButton(
              label: 'Back to Home',
              onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final deliveryDate = DateTime.now().add(const Duration(days: 5));
    final months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    final deliveryStr = '${deliveryDate.day} ${months[deliveryDate.month - 1]} ${deliveryDate.year}';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background, elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Shopping Bag',
            style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w700)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                children: [

                  // ── Cart Items ────────────────────────────────────
                  ...cart.items.map((item) => Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox(
                            width: 85, height: 100,
                            child: Image.asset(item.product.imageUrl, fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                    color: AppColors.border,
                                    child: const Icon(Icons.image_not_supported, color: AppColors.hint))),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.product.name,
                                  style: const TextStyle(color: AppColors.textPrimary,
                                      fontWeight: FontWeight.w700, fontSize: 14)),
                              const SizedBox(height: 4),
                              Text(item.product.description,
                                  maxLines: 1, overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(color: AppColors.hint, fontSize: 11)),
                              const SizedBox(height: 10),

                              // Size + Qty row
                              Row(children: [
                                _chipBox('Size  ${item.size}'),
                                const SizedBox(width: 8),
                                _chipBox('Qty  ${item.quantity}'),
                              ]),
                              const SizedBox(height: 10),

                              // Delivery date
                              Row(children: [
                                const Icon(Icons.local_shipping_outlined,
                                    color: AppColors.success, size: 14),
                                const SizedBox(width: 4),
                                const Text('Delivery by  ',
                                    style: TextStyle(color: AppColors.hint, fontSize: 11)),
                                Text(deliveryStr,
                                    style: const TextStyle(color: AppColors.primary,
                                        fontSize: 11, fontWeight: FontWeight.w700)),
                              ]),
                            ],
                          ),
                        ),

                        // Price + Delete
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Rs. ${item.product.price.toStringAsFixed(0)}',
                                style: const TextStyle(color: AppColors.primary,
                                    fontWeight: FontWeight.w800, fontSize: 14)),
                            const SizedBox(height: 4),
                            Text('Rs. ${item.product.oldPrice.toStringAsFixed(0)}',
                                style: const TextStyle(color: AppColors.hint, fontSize: 11,
                                    decoration: TextDecoration.lineThrough)),
                            const SizedBox(height: 12),
                            GestureDetector(
                              onTap: () => cart.remove(item),
                              child: const Icon(Icons.delete_outline, color: AppColors.danger, size: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),

                  // ── Coupon Section ────────────────────────────────
                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.local_offer_outlined, color: AppColors.primary, size: 20),
                        const SizedBox(width: 12),
                        const Text('Apply Coupons',
                            style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => setState(() => _couponApplied = !_couponApplied),
                          child: Text(_couponApplied ? 'Applied ✓' : 'Select',
                              style: TextStyle(
                                  color: _couponApplied ? AppColors.success : AppColors.primary,
                                  fontWeight: FontWeight.w700, fontSize: 13)),
                        ),
                      ],
                    ),
                  ),

                  // ── Order Payment Details ─────────────────────────
                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Order Payment Details',
                            style: TextStyle(color: AppColors.textPrimary,
                                fontSize: 15, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 14),
                        _payRow('Order Amounts',
                            'Rs. ${cart.subtotal.toStringAsFixed(0)}'),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              const Text('Convenience  ',
                                  style: TextStyle(color: AppColors.hint, fontSize: 13)),
                              GestureDetector(
                                onTap: () {},
                                child: const Text('Know More',
                                    style: TextStyle(color: AppColors.primary,
                                        fontSize: 11, fontWeight: FontWeight.w600)),
                              ),
                            ]),
                            GestureDetector(
                              onTap: () {},
                              child: const Text('Apply Coupon',
                                  style: TextStyle(color: AppColors.primary,
                                      fontSize: 11, fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        _payRow('Delivery Fee',
                            cart.shipping == 0 ? 'Free' : 'Rs. ${cart.shipping.toStringAsFixed(0)}',
                            valueColor: AppColors.success),
                        const Divider(color: AppColors.border, height: 24),
                        _payRow('Order Total',
                            'Rs. ${cart.total.toStringAsFixed(0)}',
                            bold: true),
                        const SizedBox(height: 8),
                        Row(children: [
                          const Text('EMI Available  ',
                              style: TextStyle(color: AppColors.hint, fontSize: 12)),
                          GestureDetector(
                            onTap: () {},
                            child: const Text('Details',
                                style: TextStyle(color: AppColors.primary,
                                    fontSize: 12, fontWeight: FontWeight.w600)),
                          ),
                        ]),
                      ],
                    ),
                  ),

                  // ── Delivery Info Form ────────────────────────────
                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Delivery Information',
                            style: TextStyle(color: AppColors.textPrimary,
                                fontSize: 15, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 14),
                        CustomTextField(
                          label: 'Full Name', controller: _nameCtrl,
                          icon: Icons.person_outline,
                          validator: (v) => v == null || v.isEmpty ? 'Name is required' : null,
                        ),
                        const SizedBox(height: 12),
                        CustomTextField(
                          label: 'Delivery Address', controller: _addrCtrl,
                          icon: Icons.location_on_outlined,
                          validator: (v) => v == null || v.isEmpty ? 'Address is required' : null,
                        ),
                        const SizedBox(height: 12),
                        CustomTextField(
                          label: 'Phone Number', controller: _phoneCtrl,
                          icon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone,
                          validator: (v) => v == null || v.isEmpty ? 'Phone is required' : null,
                        ),
                      ],
                    ),
                  ),

                  // ── Payment Method ────────────────────────────────
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Payment Method',
                            style: TextStyle(color: AppColors.textPrimary,
                                fontSize: 15, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 12),
                        ...['Cash on Delivery', 'Credit / Debit Card', 'Online Transfer']
                            .map((method) => GestureDetector(
                                  onTap: () => setState(() => _payment = method),
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: _payment == method
                                          ? AppColors.primary.withValues(alpha: 0.1)
                                          : AppColors.background,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: _payment == method
                                              ? AppColors.primary
                                              : AppColors.border),
                                    ),
                                    child: Row(children: [
                                      Icon(
                                          _payment == method
                                              ? Icons.radio_button_checked
                                              : Icons.radio_button_unchecked,
                                          color: _payment == method
                                              ? AppColors.primary
                                              : AppColors.hint,
                                          size: 20),
                                      const SizedBox(width: 10),
                                      Text(method,
                                          style: TextStyle(
                                              color: _payment == method
                                                  ? AppColors.textPrimary
                                                  : AppColors.textSecondary,
                                              fontWeight: _payment == method
                                                  ? FontWeight.w600
                                                  : FontWeight.w400)),
                                    ]),
                                  ),
                                )),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ── Bottom Bar ────────────────────────────────────────
            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                border: const Border(top: BorderSide(color: AppColors.border)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 16, offset: const Offset(0, -4)),
                ],
              ),
              child: Row(
                children: [
                  // Total on left
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Rs. ${cart.total.toStringAsFixed(0)}',
                          style: const TextStyle(color: AppColors.primary,
                              fontSize: 18, fontWeight: FontWeight.w800)),
                      GestureDetector(
                        onTap: () {},
                        child: const Text('View Details',
                            style: TextStyle(color: AppColors.hint, fontSize: 11)),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  // Button on right
                  Expanded(
                    child: CustomButton(
                      label: 'Proceed to Payment',
                      isLoading: _isPlacing,
                      onPressed: _placeOrder,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chipBox(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Text(text, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
        const Icon(Icons.keyboard_arrow_down, color: AppColors.hint, size: 14),
      ]),
    );
  }

  Widget _payRow(String label, String value, {bool bold = false, Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
                color: bold ? AppColors.textPrimary : AppColors.hint,
                fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
                fontSize: bold ? 15 : 13)),
        Text(value,
            style: TextStyle(
                color: valueColor ?? (bold ? AppColors.primary : AppColors.textPrimary),
                fontWeight: bold ? FontWeight.w800 : FontWeight.w600,
                fontSize: bold ? 16 : 13)),
      ],
    );
  }
}