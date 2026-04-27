import 'package:flutter/material.dart';
import '../core/constants/colors.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const CategoryCard({super.key, required this.title, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.card,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: selected ? AppColors.primary : AppColors.border),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: selected ? AppColors.background : AppColors.textSecondary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
