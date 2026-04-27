import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../services/database_service.dart';
import '../../widgets/product_card.dart';
import 'product_details_screen.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = DatabaseService.getProducts();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text('All Products',
            style: TextStyle(color: AppColors.textPrimary,
                fontSize: 20, fontWeight: FontWeight.w700)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: 0.68,
        ),
        itemBuilder: (context, index) => ProductCard(
          product: products[index],
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ProductDetailsScreen(product: products[index])),
          ),
        ),
      ),
    );
  }
}