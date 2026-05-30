import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants/colors.dart';
import '../providers/cart_provider.dart';
import '../providers/wishlist_provider.dart';
import '../screens/home/home_screen.dart';
import '../screens/cart/checkout_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/product/product_details_screen.dart';
import 'product_image.dart';
import '../utils/helpers.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    _WishlistScreen(),
    CheckoutScreen(),
    _OrdersScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final wishlist = context.watch<WishlistProvider>();

    return Scaffold(
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          border: const Border(top: BorderSide(color: AppColors.border)),
          boxShadow: [BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 20, offset: const Offset(0, -4))],
        ),
        child: SafeArea(
          child: SizedBox(
            height: 68,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(icon: Icons.home_rounded, label: 'Home',
                    index: 0, current: _index, onTap: (i) => setState(() => _index = i)),

                // Wishlist with badge
                _NavItemBadge(
                  icon: Icons.favorite_border_rounded,
                  activeIcon: Icons.favorite_rounded,
                  label: 'Wishlist',
                  index: 1, current: _index,
                  badgeCount: wishlist.count,
                  onTap: (i) => setState(() => _index = i),
                ),

                // Cart center button
                GestureDetector(
                  onTap: () => setState(() => _index = 2),
                  child: Container(
                    width: 54, height: 54,
                    decoration: BoxDecoration(
                      color: _index == 2 ? AppColors.primary : Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.4),
                          blurRadius: 12, offset: const Offset(0, 4))],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const Icon(Icons.shopping_cart_outlined,
                            color: AppColors.background, size: 24),
                        if (cart.itemCount > 0)
                          Positioned(
                            right: 8, top: 8,
                            child: Container(
                              width: 16, height: 16,
                              decoration: const BoxDecoration(
                                  color: AppColors.danger, shape: BoxShape.circle),
                              child: Center(child: Text('${cart.itemCount}',
                                  style: const TextStyle(color: Colors.white,
                                      fontSize: 9, fontWeight: FontWeight.w800))),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                _NavItem(icon: Icons.receipt_long_outlined, label: 'Orders',
                    index: 3, current: _index, onTap: (i) => setState(() => _index = i)),
                _NavItem(icon: Icons.settings_outlined, label: 'Setting',
                    index: 4, current: _index, onTap: (i) => setState(() => _index = i)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Nav Item ──────────────────────────────────────────────────────────────────
class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index, current;
  final void Function(int) onTap;

  const _NavItem({required this.icon, required this.label,
      required this.index, required this.current, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final sel = index == current;
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(width: 56,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, color: sel ? AppColors.primary : AppColors.hint, size: 24),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(
              color: sel ? AppColors.primary : AppColors.hint,
              fontSize: 10, fontWeight: sel ? FontWeight.w700 : FontWeight.w400)),
        ]),
      ),
    );
  }
}

// Nav item with badge count
class _NavItemBadge extends StatelessWidget {
  final IconData icon, activeIcon;
  final String label;
  final int index, current, badgeCount;
  final void Function(int) onTap;

  const _NavItemBadge({required this.icon, required this.activeIcon,
      required this.label, required this.index, required this.current,
      required this.badgeCount, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final sel = index == current;
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(width: 56,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(sel ? activeIcon : icon,
                  color: sel ? AppColors.primary : AppColors.hint, size: 24),
              if (badgeCount > 0)
                Positioned(
                  right: -6, top: -4,
                  child: Container(
                    width: 16, height: 16,
                    decoration: const BoxDecoration(
                        color: AppColors.danger, shape: BoxShape.circle),
                    child: Center(child: Text('$badgeCount',
                        style: const TextStyle(color: Colors.white,
                            fontSize: 9, fontWeight: FontWeight.w800))),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(
              color: sel ? AppColors.primary : AppColors.hint,
              fontSize: 10, fontWeight: sel ? FontWeight.w700 : FontWeight.w400)),
        ]),
      ),
    );
  }
}

// ── Wishlist Screen ───────────────────────────────────────────────────────────
class _WishlistScreen extends StatelessWidget {
  const _WishlistScreen();

  @override
  Widget build(BuildContext context) {
    final wishlist = context.watch<WishlistProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background, elevation: 0,
        title: const Text('Wishlist',
            style: TextStyle(color: AppColors.textPrimary,
                fontSize: 20, fontWeight: FontWeight.w700)),
        centerTitle: true,
      ),
      body: wishlist.items.isEmpty
          ? const Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.favorite_border_rounded, color: AppColors.primary, size: 72),
                SizedBox(height: 16),
                Text('Your wishlist is empty',
                    style: TextStyle(color: AppColors.textPrimary,
                        fontSize: 20, fontWeight: FontWeight.w700)),
                SizedBox(height: 8),
                Text('Tap ❤️ on any product to save it here',
                    style: TextStyle(color: AppColors.hint)),
              ]),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: wishlist.items.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 14,
                crossAxisSpacing: 14, childAspectRatio: 0.68,
              ),
              itemBuilder: (_, i) {
                final p = wishlist.items[i];
                return GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ProductDetailsScreen(product: p))),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Stack(children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                              child: ProductImage(
                                imageUrl: p.imageUrl,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            // Remove from wishlist
                            Positioned(
                              top: 8, right: 8,
                              child: GestureDetector(
                                onTap: () => wishlist.toggle(p),
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: AppColors.background.withValues(alpha: 0.8),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.favorite,
                                      color: AppColors.danger, size: 18),
                                ),
                              ),
                            ),
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(p.name, maxLines: 1, overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(color: AppColors.textPrimary,
                                      fontWeight: FontWeight.w700, fontSize: 13)),
                              const SizedBox(height: 2),
                              Text(p.category,
                                  style: const TextStyle(color: AppColors.primary, fontSize: 11)),
                              const SizedBox(height: 4),
                              Text(Helpers.formatPrice(p.price),
                                  style: const TextStyle(color: AppColors.primary,
                                      fontWeight: FontWeight.w800, fontSize: 13)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

// ── Orders Placeholder ────────────────────────────────────────────────────────
class _OrdersScreen extends StatelessWidget {
  const _OrdersScreen();
  @override
  Widget build(BuildContext context) => const Scaffold(
    body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(Icons.receipt_long_outlined, color: AppColors.primary, size: 64),
      SizedBox(height: 16),
      Text('Orders', style: TextStyle(color: AppColors.textPrimary,
          fontSize: 22, fontWeight: FontWeight.w700)),
      SizedBox(height: 8),
      Text('No orders yet', style: TextStyle(color: AppColors.hint)),
    ])),
  );
}
