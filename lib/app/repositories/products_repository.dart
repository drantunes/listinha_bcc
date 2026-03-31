import 'dart:collection';

import 'package:listinha/app/models/cart_item.dart';
import 'package:listinha/app/models/product.dart';

class ProductsRepository {
  final List<CartItem> _cartItems = [];
  final List<Product> _productsList = [];

  UnmodifiableListView<CartItem> get cartItems => UnmodifiableListView(_cartItems);
  UnmodifiableListView<Product> get products => UnmodifiableListView(_productsList);

  void addProduct(String productName) {
    _productsList.add(
      Product(title: productName),
    );
  }

  List<Product> loadProducts() {
    return products;
  }

  void toggleCartItem(Product product) {
    int productIndex = _cartItems.indexWhere(
      (item) => item.product.title == product.title,
    );
    if (productIndex >= 0) {
      _cartItems.removeAt(productIndex);
      return;
    }
    _cartItems.add(CartItem(product: product, amount: 1));
  }

  void _changeAmount(CartItem cartItem, int amount) {
    final index = cartItems.indexWhere(
      (item) => item.product.title == cartItem.product.title,
    );
    _cartItems[index] = CartItem(product: cartItem.product, amount: amount);
  }

  void increase(CartItem cartItem) {
    final amount = cartItem.amount + 1;
    _changeAmount(cartItem, amount);
  }

  void decrease(CartItem cartItem) {
    final amount = (cartItem.amount == 0) ? 0 : cartItem.amount - 1;
    _changeAmount(cartItem, amount);
  }
}
