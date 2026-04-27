import 'package:flutter/material.dart';
import '../models/product_model.dart';

class WishlistProvider extends ChangeNotifier {
  final List<ProductModel> _items = [];

  List<ProductModel> get items => List.unmodifiable(_items);
  int get count => _items.length;

  bool isFav(String productId) => _items.any((p) => p.id == productId);

  void toggle(ProductModel product) {
    if (isFav(product.id)) {
      _items.removeWhere((p) => p.id == product.id);
    } else {
      _items.add(product);
    }
    notifyListeners();
  }
}
