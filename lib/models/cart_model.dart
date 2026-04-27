import 'product_model.dart';

class CartItem {
  final ProductModel product;
  final String size;
  int quantity;

  CartItem({required this.product, required this.size, this.quantity = 1});

  double get total => product.price * quantity;
}

class Cart {
  final List<CartItem> items;
  Cart({required this.items});

  double get totalPrice => items.fold(0, (sum, item) => sum + item.total);
  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);
}
