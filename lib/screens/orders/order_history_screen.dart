import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/styles.dart';
import '../../services/database_service.dart';
import '../../utils/helpers.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = DatabaseService.getOrders();

    return Scaffold(
      appBar: AppBar(title: const Text('Order History', style: AppStyles.h2)),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: orders.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final order = orders[index];
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Order #${order.id}', style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w800)),
                const SizedBox(height: 6),
                Text('Status: ${order.status}', style: const TextStyle(color: AppColors.primary)),
                const SizedBox(height: 6),
                Text('Amount: ${Helpers.formatPrice(order.totalAmount)}', style: const TextStyle(color: AppColors.textSecondary)),
              ],
            ),
          );
        },
      ),
    );
  }
}
