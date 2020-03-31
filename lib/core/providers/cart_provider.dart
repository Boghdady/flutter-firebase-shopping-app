import 'package:firebase_shop_app/core/models/cart_item.dart';
import 'package:flutter/foundation.dart';

class CartProvider with ChangeNotifier {
  // Every cardItem have unique id not the id of product
  // Map<key, value> => key will be the id of the CartItem
  Map<String, CartItem> _cartItems = {};

  // getter to get cart items
  Map<String, CartItem> get cartItems {
    return {..._cartItems};
  }

  // getter to get cart items count
  int get itemsCount => _cartItems.length;
  double get totalPriceAmount {
    var total = 0.0;
    _cartItems.forEach((key, cardItem) {
      total += cardItem.price * cardItem.quantity;
    });
    return total;
  }

  bool checkProductAddedToCart(productId) {
    if (_cartItems.containsKey(productId)) {
      return true;
    } else {
      return false;
    }
  }

  int numberOfProductsInSingleItem(String productId) {
    var cartItem =
        _cartItems.values.firstWhere((cartItem) => cartItem.id == productId);
    return cartItem.quantity;
  }

  void increaseNumberOfProductsInCartItem(String productId) {
    _cartItems.update(
        productId,
        (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              price: existingCartItem.price,
              imageUrl: existingCartItem.imageUrl,
              quantity: existingCartItem.quantity + 1,
            ));
    notifyListeners();
  }

  void decreaseNumberOfProductsInCartItem(String productId) {
    _cartItems.update(
        productId,
        (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              price: existingCartItem.price,
              imageUrl: existingCartItem.imageUrl,
              quantity: (existingCartItem.quantity == 0)
                  ? 0
                  : existingCartItem.quantity - 1,
            ));
    notifyListeners();
  }

  void addItemToCart(
      String productId, String title, double price, String imageUrl) {
    // Check if cart contain product
    if (_cartItems.containsKey(productId)) {
      // Increase quantity
      _cartItems.update(
          productId,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                title: existingCartItem.title,
                price: existingCartItem.price,
                imageUrl: existingCartItem.imageUrl,
                quantity: existingCartItem.quantity + 1,
              ));
    } else {
      // Add product to cart
      _cartItems.putIfAbsent(
          productId,
          () => CartItem(
                id: productId,
                title: title,
                imageUrl: imageUrl,
                quantity: 1,
                price: price,
              ));
    }
    notifyListeners();
  }

  void removeItemFromCart(String itemId) {
    _cartItems.remove(itemId);
    notifyListeners();
  }

  void clearCart() {
    _cartItems = {};
    notifyListeners();
  }
}
