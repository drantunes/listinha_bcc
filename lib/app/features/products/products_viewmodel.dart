import 'package:flutter/material.dart';
import 'package:listinha/app/models/cart_item.dart';
import 'package:listinha/app/models/product.dart';
import 'package:listinha/app/repositories/products_repository.dart';

class EmptyProduct extends Product {
  EmptyProduct({required super.title});
}

class ProductsViewmodel extends ChangeNotifier {
  bool isLoaded = false;
  bool isSaved = false;
  List<Product> products = [];
  final ProductsRepository productsRepository;

  ProductsViewmodel({required this.productsRepository});

  void load() async {
    // isLoaded = false;
    // notifyListeners();
    products = await productsRepository.loadProducts();
    isLoaded = true;
    notifyListeners();
  }

  void saveProduct(String productName) async {
    // p/ controlar o loading da tela
    products = [...products, EmptyProduct(title: productName)];
    isSaved = true;
    notifyListeners();

    await productsRepository.addProduct(productName);
    isSaved = false;
    load();
  }

  void increase(CartItem cartItem) {
    productsRepository.increase(cartItem);
    notifyListeners();
  }

  void decrease(CartItem cartItem) {
    productsRepository.decrease(cartItem);
    notifyListeners();
  }

  void toggleCartItem(Product product) {
    productsRepository.toggleCartItem(product);
    notifyListeners();
  }
}
