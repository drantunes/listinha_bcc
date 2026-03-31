import 'package:flutter/material.dart';
import 'package:listinha/app/features/products/products_screen.dart';
import 'package:listinha/app/repositories/products_repository.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final productsRepository = ProductsRepository();

    return MaterialApp(
      title: 'Listinha',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
        ),
      ),
      home: ProductsScreen(
        productsRepository: productsRepository,
      ),
    );
  }
}
