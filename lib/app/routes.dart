import 'package:go_router/go_router.dart';
import 'package:listinha/app/features/cart_items/cart_items_screen.dart';
import 'package:listinha/app/features/products/add_product_screen.dart';
import 'package:listinha/app/features/products/products_screen.dart';
import 'package:provider/provider.dart';

final class Routes {
  static const products = '/products';
  static const addProducts = '/add-products';
  static const cartItems = '/cartItems';
}

final routes = GoRouter(
  initialLocation: Routes.products,
  routes: [
    GoRoute(
      path: Routes.products,
      builder: (context, state) => ProductsScreen(
        productsViewmodel: context.read(),
      ),
    ),
    GoRoute(
      path: Routes.addProducts,
      builder: (context, state) => AddProductScreen(
        productsViewmodel: context.read(),
      ),
    ),
    GoRoute(
      path: Routes.cartItems,
      builder: (context, state) => CartItemsScreen(
        productsViewmodel: context.read(),
      ),
    ),
  ],
);
