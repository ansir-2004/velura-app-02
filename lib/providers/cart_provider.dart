import 'package:flutter/material.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);
  int get itemCount => _items.fold(0, (sum, i) => sum + i.quantity);
  double get subtotal => _items.fold(0, (sum, i) => sum + i.total);
  double get shipping => _items.isEmpty ? 0 : 299;
  double get total => subtotal + shipping;

  void addToCart(ProductModel product, String size) {
    final index = _items.indexWhere((e) => e.product.id == product.id && e.size == size);
    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(CartItem(product: product, size: size));
    }
    notifyListeners();
  }

  void increase(CartItem item) {
    final index = _items.indexWhere((e) => e.product.id == item.product.id && e.size == item.size);
    if (index >= 0) { _items[index].quantity++; notifyListeners(); }
  }

  void decrease(CartItem item) {
    final index = _items.indexWhere((e) => e.product.id == item.product.id && e.size == item.size);
    if (index >= 0) {
      if (_items[index].quantity > 1) { _items[index].quantity--; }
      else { _items.removeAt(index); }
      notifyListeners();
    }
  }

  void remove(CartItem item) {
    _items.removeWhere((e) => e.product.id == item.product.id && e.size == item.size);
    notifyListeners();
  }

  void clear() { _items.clear(); notifyListeners(); }
}