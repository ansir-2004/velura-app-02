import 'package:flutter/material.dart';
import '../core/constants/colors.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool outline;

  const CustomButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.outline = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: outline ? Colors.transparent : AppColors.primary,
          foregroundColor: outline ? AppColors.primary : AppColors.background,
          side: outline ? const BorderSide(color: AppColors.primary, width: 1.5) : BorderSide.none,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: outline ? 0 : 4,
        ),
        child: isLoading
            ? const SizedBox(width: 22, height: 22,
                child: CircularProgressIndicator(color: AppColors.background, strokeWidth: 2.5))
            : Text(label,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, letterSpacing: 0.5)),
      ),
    );
  }
}