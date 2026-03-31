import 'package:flutter/material.dart';
import 'package:listinha/app/features/cart_items/cart_items_screen.dart';
import 'package:listinha/app/features/products/add_product_screen.dart';
import 'package:listinha/app/models/product.dart';
import 'package:listinha/app/repositories/products_repository.dart';
import 'package:listinha/app/widgets/avatar.dart';
import 'package:listinha/app/widgets/shopping_button.dart';

class ProductsScreen extends StatefulWidget {
  final ProductsRepository productsRepository;

  const ProductsScreen({
    super.key,
    required this.productsRepository,
  });

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    products.addAll(widget.productsRepository.loadProducts());
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = widget.productsRepository.cartItems;
    return Scaffold(
      appBar: AppBar(
        title: Text('Listinha'),
        centerTitle: true,
        leading: Avatar(),
        actions: [
          ShoppingButton(
            count: cartItems.length,
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CartItemsScreen(
                  productsRepository: widget.productsRepository,
                  update: () => setState(() {}),
                ),
                fullscreenDialog: true,
              ),
            ),
          ),
        ],
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => ListTile(
          title: Text(products[index].title),
          trailing: Switch(
            value: cartItems.any((p) => p.product.title == products[index].title),
            onChanged: (value) {
              setState(() {
                widget.productsRepository.toggleCartItem(products[index]);
              });
            },
          ),
        ),
        separatorBuilder: (_, _) => Divider(),
        itemCount: products.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AddProductScreen(
              productsRepository: widget.productsRepository,
              updateScreen: updateScreen,
            ),
            fullscreenDialog: true,
          ),
        ),
        child: Icon(Icons.add_shopping_cart_outlined),
      ),
    );
  }

  void updateScreen() {
    setState(() {
      products = widget.productsRepository.products;
    });
  }
}
