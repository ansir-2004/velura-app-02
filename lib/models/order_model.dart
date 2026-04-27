import 'cart_model.dart';

class OrderModel {
  final String id;
  final DateTime date;
  final List<CartItem> items;
  final double totalAmount;
  final String status;

  OrderModel({
    required this.id,
    required this.date,
    required this.items,
    required this.totalAmount,
    required this.status,
  });
}
