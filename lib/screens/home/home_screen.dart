import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/colors.dart';
import '../../providers/cart_provider.dart';
import '../../models/product_model.dart';
import '../../services/database_service.dart';
import '../../widgets/product_card.dart';
import '../product/product_details_screen.dart';
import '../product/product_list_screen.dart';
import '../profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'All';
  String _searchQuery = '';
  final _searchCtrl = TextEditingController();
  final List<String> _categories = ['All', 'Men', 'Women', 'Kids', 'Accessories', 'Shoes'];

  @override
  void dispose() { _searchCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text('Discover Luxury',
            style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w800, fontSize: 20)),
        actions: [
          // Cart icon with badge
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_bag_outlined, color: AppColors.textPrimary),
                onPressed: () => Navigator.pushNamed(context, '/cart'),
              ),
              if (cart.itemCount > 0)
                Positioned(
                  right: 6, top: 6,
                  child: Container(
                    width: 18, height: 18,
                    decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                    child: Center(child: Text('${cart.itemCount}',
                        style: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.w800))),
                  ),
                ),
            ],
          ),
          // Profile icon → ProfileScreen
          IconButton(
            icon: const Icon(Icons.person_outline, color: AppColors.textPrimary),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const ProfileScreen())),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Hero Banner
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.card, AppColors.secondary],
                begin: Alignment.topLeft, end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('NEW COLLECTION',
                    style: TextStyle(color: AppColors.primary, fontSize: 12,
                        fontWeight: FontWeight.w600, letterSpacing: 1.2)),
                const SizedBox(height: 8),
                const Text('Unique luxury\ndesign for you',
                    style: TextStyle(color: AppColors.textPrimary, fontSize: 22,
                        fontWeight: FontWeight.w800, height: 1.3)),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(20)),
                  child: const Text('Shop Now',
                      style: TextStyle(color: AppColors.background, fontWeight: FontWeight.w700, fontSize: 13)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Search
          TextField(
            controller: _searchCtrl,
            style: const TextStyle(color: AppColors.textPrimary),
            onChanged: (v) => setState(() => _searchQuery = v),
            decoration: InputDecoration(
              hintText: 'Search fashion...',
              hintStyle: const TextStyle(color: AppColors.hint),
              prefixIcon: const Icon(Icons.search, color: AppColors.primary),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, color: AppColors.hint),
                      onPressed: () { _searchCtrl.clear(); setState(() => _searchQuery = ''); })
                  : null,
              filled: true, fillColor: AppColors.card,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: AppColors.border)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: AppColors.border)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: AppColors.primary)),
            ),
          ),
          const SizedBox(height: 20),

          // Categories
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) {
                final cat = _categories[i];
                final sel = cat == _selectedCategory;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = cat),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    decoration: BoxDecoration(
                      color: sel ? AppColors.primary : AppColors.card,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: sel ? AppColors.primary : AppColors.border),
                    ),
                    child: Text(cat,
                        style: TextStyle(
                            color: sel ? AppColors.background : AppColors.textSecondary,
                            fontWeight: sel ? FontWeight.w700 : FontWeight.w400,
                            fontSize: 13)),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),

          StreamBuilder<List<ProductModel>>(
            stream: DatabaseService.getProductsStream(category: _selectedCategory),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(40),
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Text('Error loading products', style: const TextStyle(color: AppColors.hint)),
                  ),
                );
              }

              var products = snapshot.data ?? [];
              if (_searchQuery.isNotEmpty) {
                products = products.where((p) =>
                    p.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                    p.category.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${products.length} Products',
                          style: const TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w600)),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ProductListScreen()),
                        ),
                        child: const Text('See all', style: TextStyle(color: AppColors.primary, fontSize: 13)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  products.isEmpty
                      ? const Center(child: Padding(
                          padding: EdgeInsets.all(40),
                          child: Text('No products found', style: TextStyle(color: AppColors.hint))))
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: products.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, mainAxisSpacing: 14,
                            crossAxisSpacing: 14, childAspectRatio: 0.68,
                          ),
                          itemBuilder: (_, i) => ProductCard(
                            product: products[i],
                            onTap: () => Navigator.push(context,
                                MaterialPageRoute(builder: (_) => ProductDetailsScreen(product: products[i]))),
                          ),
                        ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}