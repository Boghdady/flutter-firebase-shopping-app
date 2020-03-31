import 'package:firebase_shop_app/core/models/cart_item.dart';
import 'package:firebase_shop_app/core/models/order_item.dart';
import 'package:flutter/foundation.dart';

class OrdersProvider with ChangeNotifier {
  List<OrderItem> _orders = [];

  // get all orders
  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartItems, double total) {
    // add order in the first List
    _orders.insert(
        0,
        OrderItem(
          dateTime: DateTime.now(),
          id: DateTime.now().toString(),
          amount: total,
          products: cartItems,
        ));
    notifyListeners();
  }
}
