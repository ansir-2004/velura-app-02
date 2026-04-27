import '../models/product_model.dart';
import '../models/order_model.dart';
import '../models/cart_model.dart';

class DatabaseService {
  static final List<ProductModel> products = [

    // MEN (5)
    ProductModel(
      id: 'p1', name: 'Velura Noir Blazer', category: 'Men',
      description: 'Luxury tailored blazer with premium finish.',
      imageUrl: 'assets/images/men/m1.jpg',
      price: 4999, oldPrice: 7999, rating: 4.8, sizes: ['S','M','L','XL'],
    ),
    ProductModel(
      id: 'p2', name: 'Velura Street Tee', category: 'Men',
      description: 'Minimal oversized tee with soft premium cotton.',
      imageUrl: 'assets/images/men/m2.jpg',
      price: 1299, oldPrice: 1999, rating: 4.4, sizes: ['S','M','L','XL'],
    ),
    ProductModel(
      id: 'p3', name: 'Obsidian Slim Chinos', category: 'Men',
      description: 'Tailored slim-fit chinos in stretch twill.',
      imageUrl: 'assets/images/men/m3.jpg',
      price: 2499, oldPrice: 3999, rating: 4.5, sizes: ['28','30','32','34','36'],
    ),
    ProductModel(
      id: 'p4', name: 'Velura Oxford Shirt', category: 'Men',
      description: 'Crisp oxford weave shirt with subtle Velura embroidery.',
      imageUrl: 'assets/images/men/m4.jpg',
      price: 1999, oldPrice: 2999, rating: 4.5, sizes: ['S','M','L','XL','XXL'],
    ),
    ProductModel(
      id: 'p5', name: 'Velura Linen Suit', category: 'Men',
      description: 'Two-piece linen suit — effortlessly refined.',
      imageUrl: 'assets/images/men/m5.jpg',
      price: 9499, oldPrice: 14999, rating: 4.8, sizes: ['S','M','L','XL'],
    ),

    // WOMEN (5)
    ProductModel(
      id: 'p6', name: 'Aurelia Silk Dress', category: 'Women',
      description: 'Elegant evening dress with luxury silhouette.',
      imageUrl: 'assets/images/women/w1.jpg',
      price: 6499, oldPrice: 9999, rating: 4.9, sizes: ['XS','S','M','L'],
    ),
    ProductModel(
      id: 'p7', name: 'Velura Trench Coat', category: 'Women',
      description: 'Classic belted trench coat in premium gabardine.',
      imageUrl: 'assets/images/women/w2.jpg',
      price: 8999, oldPrice: 13999, rating: 4.9, sizes: ['XS','S','M','L','XL'],
    ),
    ProductModel(
      id: 'p8', name: 'Luna Wrap Skirt', category: 'Women',
      description: 'Flowing wrap skirt in satin finish.',
      imageUrl: 'assets/images/women/w3.jpg',
      price: 2799, oldPrice: 4499, rating: 4.6, sizes: ['XS','S','M','L'],
    ),
    ProductModel(
      id: 'p9', name: 'Celestia Maxi Dress', category: 'Women',
      description: 'Bohemian-luxe maxi dress in floral jacquard.',
      imageUrl: 'assets/images/women/w4.jpg',
      price: 5299, oldPrice: 7999, rating: 4.8, sizes: ['XS','S','M','L'],
    ),
    ProductModel(
      id: 'p10', name: 'Soleil Crop Blazer', category: 'Women',
      description: 'Structured crop blazer in ivory.',
      imageUrl: 'assets/images/women/w5.jpg',
      price: 5499, oldPrice: 8499, rating: 4.8, sizes: ['XS','S','M','L'],
    ),

    // KIDS (4)
    ProductModel(
      id: 'p11', name: 'Mini Velura Hoodie', category: 'Kids',
      description: 'Super soft cotton hoodie for little ones.',
      imageUrl: 'assets/images/kids/k1.jpg',
      price: 899, oldPrice: 1499, rating: 4.7, sizes: ['2Y','4Y','6Y','8Y'],
    ),
    ProductModel(
      id: 'p12', name: 'Tiny Stars Dress', category: 'Kids',
      description: 'Adorable printed dress with tulle overlay.',
      imageUrl: 'assets/images/kids/k2.jpg',
      price: 1099, oldPrice: 1799, rating: 4.8, sizes: ['2Y','4Y','6Y','8Y'],
    ),
    ProductModel(
      id: 'p13', name: 'Junior Denim Jacket', category: 'Kids',
      description: 'Classic denim jacket with fun patch details.',
      imageUrl: 'assets/images/kids/k3.jpg',
      price: 1299, oldPrice: 1999, rating: 4.6, sizes: ['4Y','6Y','8Y','10Y'],
    ),
    ProductModel(
      id: 'p14', name: 'Velura Kids Joggers', category: 'Kids',
      description: 'Comfortable everyday joggers with elastic waist.',
      imageUrl: 'assets/images/kids/k4.jpg',
      price: 799, oldPrice: 1299, rating: 4.5, sizes: ['2Y','4Y','6Y','8Y','10Y'],
    ),

    // ACCESSORIES (3)
    ProductModel(
      id: 'p15', name: 'Noir Crossbody Bag', category: 'Accessories',
      description: 'Compact leather crossbody bag with chain strap.',
      imageUrl: 'assets/images/accessories/a1.jpg',
      price: 3499, oldPrice: 5499, rating: 4.8, sizes: ['One Size'],
    ),
    ProductModel(
      id: 'p16', name: 'Gold Cuff Bracelet', category: 'Accessories',
      description: 'Minimalist wide cuff in 18K gold-plated brass.',
      imageUrl: 'assets/images/accessories/a2.jpg',
      price: 1799, oldPrice: 2999, rating: 4.6, sizes: ['One Size'],
    ),
    ProductModel(
      id: 'p17', name: 'Dusk Leather Tote', category: 'Accessories',
      description: 'Spacious full-grain leather tote with suede lining.',
      imageUrl: 'assets/images/accessories/a3.jpg',
      price: 5999, oldPrice: 8999, rating: 4.7, sizes: ['One Size'],
    ),

    // SHOES (3)
    ProductModel(
      id: 'p18', name: 'Regent Leather Boots', category: 'Shoes',
      description: 'Premium boots crafted for style and comfort.',
      imageUrl: 'assets/images/shoes/s1.jpg',
      price: 5599, oldPrice: 8999, rating: 4.7, sizes: ['6','7','8','9','10'],
    ),
    ProductModel(
      id: 'p19', name: 'Phantom Sneakers', category: 'Shoes',
      description: 'Luxury low-top sneakers with leather upper.',
      imageUrl: 'assets/images/shoes/s2.jpg',
      price: 6999, oldPrice: 9999, rating: 4.9, sizes: ['6','7','8','9','10','11'],
    ),
    ProductModel(
      id: 'p20', name: 'Onyx Ankle Heels', category: 'Shoes',
      description: 'Sleek pointed-toe ankle heels in patent leather.',
      imageUrl: 'assets/images/shoes/s3.jpg',
      price: 4799, oldPrice: 6999, rating: 4.6, sizes: ['5','6','7','8','9'],
    ),
  ];

  static List<ProductModel> getProducts({String? category}) {
    if (category == null || category == 'All') return products;
    return products.where((e) => e.category == category).toList();
  }

  static List<OrderModel> getOrders() {
    return [
      OrderModel(
        id: 'o1001',
        date: DateTime.now().subtract(const Duration(days: 3)),
        items: [CartItem(product: products.first, size: 'M', quantity: 1)],
        totalAmount: 4999, status: 'Delivered',
      ),
      OrderModel(
        id: 'o1002',
        date: DateTime.now().subtract(const Duration(days: 1)),
        items: [CartItem(product: products[1], size: 'S', quantity: 1)],
        totalAmount: 6499, status: 'Shipped',
      ),
    ];
  }
}