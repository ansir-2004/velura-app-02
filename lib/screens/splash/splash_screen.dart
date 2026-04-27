import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _fade  = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeIn));
    _scale = Tween<double>(begin: 0.7, end: 1).animate(CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut));
    _ctrl.forward();
    // Navigate to login after 2 seconds
    Timer(const Duration(seconds: 2), () {
      if (mounted) Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: FadeTransition(
          opacity: _fade,
          child: ScaleTransition(
            scale: _scale,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 110, height: 110,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primary, width: 2),
                    color: AppColors.card,
                  ),
                  child: const Icon(Icons.diamond_outlined, color: AppColors.primary, size: 52),
                ),
                const SizedBox(height: 24),
                const Text('VELURA',
                    style: TextStyle(color: AppColors.primary, fontSize: 36,
                        fontWeight: FontWeight.w900, letterSpacing: 8)),
                const SizedBox(height: 8),
                const Text('Unique Luxury Fashion',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 14, letterSpacing: 2)),
                const SizedBox(height: 48),
                const SizedBox(width: 24, height: 24,
                  child: CircularProgressIndicator(color: AppColors.primary, strokeWidth: 2)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
