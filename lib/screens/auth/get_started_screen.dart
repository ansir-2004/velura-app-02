import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../widgets/custom_button.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                width: 130, height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary, width: 2),
                  color: AppColors.card,
                ),
                child: const Icon(Icons.check_circle_outline, color: AppColors.primary, size: 64),
              ),
              const SizedBox(height: 36),
              const Text('Account Created!',
                  style: TextStyle(color: AppColors.textPrimary, fontSize: 28, fontWeight: FontWeight.w800)),
              const SizedBox(height: 12),
              const Text(
                'Welcome to Velura. Your luxury fashion journey begins now. Explore exclusive collections crafted just for you.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textSecondary, fontSize: 15, height: 1.6),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _feature(Icons.diamond_outlined, 'Luxury'),
                  _feature(Icons.local_shipping_outlined, 'Fast Delivery'),
                  _feature(Icons.verified_outlined, 'Authentic'),
                ],
              ),
              const Spacer(),
              CustomButton(
                label: 'Get Started',
                onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _feature(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
          ),
          child: Icon(icon, color: AppColors.primary, size: 28),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
      ],
    );
  }
}
