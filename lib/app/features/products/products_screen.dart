import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:listinha/app/features/products/products_viewmodel.dart';
import 'package:listinha/app/routes.dart';
import 'package:listinha/app/widgets/avatar.dart';
import 'package:listinha/app/widgets/shopping_button.dart';

class ProductsScreen extends StatefulWidget {
  final ProductsViewmodel productsViewmodel;

  const ProductsScreen({
    super.key,
    required this.productsViewmodel,
  });

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    super.initState();
    widget.productsViewmodel.load();
    widget.productsViewmodel.addListener(onUpdate);
  }

  @override
  void dispose() {
    widget.productsViewmodel.removeListener(onUpdate);
    super.dispose();
  }

  void onUpdate() {
    if (widget.productsViewmodel.isSaved) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Produto salvo')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = widget.productsViewmodel;
    final cartItems = vm.productsRepository.cartItems;
    return ListenableBuilder(
      listenable: vm,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Listinha'),
            centerTitle: true,
            leading: Avatar(),
            actions: [
              ShoppingButton(
                count: cartItems.length,
                // onPressed: () => Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => CartItemsScreen(
                //       productsViewmodel: context.read(),
                //     ),
                //     fullscreenDialog: true,
                //   ),
                // ),
                onPressed: () => context.push(Routes.cartItems),
              ),
            ],
          ),
          body: (!vm.isLoaded)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  itemBuilder: (context, index) => ListTile(
                    title: Text(vm.products[index].title),
                    trailing: (vm.products[index] is EmptyProduct)
                        ? SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(),
                          )
                        : Switch(
                            value: cartItems.any(
                              (p) => p.product.title == vm.products[index].title,
                            ),
                            onChanged: (value) {
                              // setState(() {
                              vm.toggleCartItem(vm.products[index]);
                              // });
                            },
                          ),
                  ),
                  separatorBuilder: (_, _) => Divider(),
                  itemCount: vm.products.length,
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => context.push(Routes.addProducts),
            child: Icon(Icons.add_shopping_cart_outlined),
          ),
        );
      },
    );
  }
}
