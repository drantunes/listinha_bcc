import 'package:flutter/material.dart';
import 'package:listinha/app/repositories/products_repository.dart';
import 'package:listinha/app/widgets/avatar.dart';
import 'package:listinha/app/widgets/shopping_button.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = ProductsRepository().products;
    return Scaffold(
      appBar: AppBar(
        title: Text('Listinha'),
        centerTitle: true,
        leading: Avatar(),
        actions: [
          ShoppingButton(
            count: 0,
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => ListTile(
          title: Text(products[index].title),
          trailing: Switch(value: true, onChanged: (value) {}),
        ),
        separatorBuilder: (_, _) => Divider(),
        itemCount: products.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add_shopping_cart_outlined),
      ),
    );
  }
}
