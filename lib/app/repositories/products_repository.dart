import 'package:listinha/models/cart_item.dart';
import 'package:listinha/models/product.dart';

class ProductsRepository {
  List<Product> get products => [
    Product(title: 'Banana'),
    Product(title: 'Coca'),
    Product(title: 'Sabor Chocolate'),
  ];
  List<CartItem> get cartItems => [];
}
