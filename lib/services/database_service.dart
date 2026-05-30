import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';
import '../models/order_model.dart';
import '../models/cart_model.dart';

class DatabaseService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Retrieves a real-time stream of products from Firestore, optionally filtered by category
  static Stream<List<ProductModel>> getProductsStream({String? category}) {
    Query query = _db.collection('products');
    if (category != null && category != 'All') {
      query = query.where('category', isEqualTo: category);
    }
    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ProductModel.fromFirestore(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }).toList();
    });
  }

  /// Decoupled mock order history
  static List<OrderModel> getOrders() {
    return [
      OrderModel(
        id: 'o1001',
        date: DateTime.now().subtract(const Duration(days: 3)),
        items: [
          CartItem(
            product: const ProductModel(
              id: 'p1',
              name: 'Velura Noir Blazer',
              category: 'Men',
              description: 'Luxury tailored blazer with premium finish.',
              imageUrl: 'assets/images/men/m1.jpg',
              price: 4999,
              oldPrice: 7999,
              rating: 4.8,
              sizes: ['S', 'M', 'L', 'XL'],
            ),
            size: 'M',
            quantity: 1,
          )
        ],
        totalAmount: 4999,
        status: 'Delivered',
      ),
      OrderModel(
        id: 'o1002',
        date: DateTime.now().subtract(const Duration(days: 1)),
        items: [
          CartItem(
            product: const ProductModel(
              id: 'p6',
              name: 'Aurelia Silk Dress',
              category: 'Women',
              description: 'Elegant evening dress with luxury silhouette.',
              imageUrl: 'assets/images/women/w1.jpg',
              price: 6499,
              oldPrice: 9999,
              rating: 4.9,
              sizes: ['XS', 'S', 'M', 'L'],
            ),
            size: 'S',
            quantity: 1,
          )
        ],
        totalAmount: 6499,
        status: 'Shipped',
      ),
    ];
  }
}