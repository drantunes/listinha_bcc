import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:listinha/app/features/cart_items/cart_items_screen.dart';
import 'package:listinha/app/features/products/products_viewmodel.dart';
import 'package:listinha/app/routes.dart';
import 'package:listinha/app/theme.dart';
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

  double size = 50;

  @override
  Widget build(BuildContext context) {
    final vm = widget.productsViewmodel;
    final cartItems = vm.productsRepository.cartItems;
    return ListenableBuilder(
      listenable: Listenable.merge([vm, themeNotifier]),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Listinha'),
            centerTitle: true,
            leading: Avatar(),
            actions: [
              // ValueListenableBuilder(
              // valueListenable: themeNotifier,
              // builder: (context, theme, _) {
              //return
              IconButton(
                onPressed: () => themeNotifier.value == ThemeMode.light
                    ? themeNotifier.value = ThemeMode.dark
                    : themeNotifier.value = ThemeMode.light,
                icon: Icon(
                  themeNotifier.value == ThemeMode.dark ? Icons.sunny : Icons.nightlight,
                ),
                // );
                // },
              ),
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
                // onPressed: () => context.push(Routes.cartItems),
                onPressed: () => showModalBottomSheet(
                  context: context,
                  useRootNavigator: true,

                  builder: (context) => CartItemsScreen(
                    productsViewmodel: widget.productsViewmodel,
                  ),
                ),
              ),
            ],
          ),
          // body: Center(
          //   child: Column(
          //     mainAxisAlignment: .center,
          //     children: [
          //       GestureDetector(
          //         onTap: () => Navigator.of(context).push(
          //           MaterialPageRoute(
          //             builder: (context) => Scaffold(
          //               appBar: AppBar(),
          //               body: Center(
          //                 child: Hero(
          //                   tag: 'profile',
          //                   child: Image.asset('assets/images/profile.png'),
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //         child: SizedBox(
          //           width: 100,
          //           height: 100,
          //           child: Hero(
          //             tag: 'profile',
          //             child: Image.asset('assets/images/profile.png'),
          //           ),
          //         ),
          //       ),
          //       AnimatedSwitcher(
          //         duration: Durations.medium2,
          //         transitionBuilder: (child, animation) => RotationTransition(
          //           turns: animation,
          //           child: child,
          //         ),
          //         child: Text(
          //           key: ValueKey(size),
          //           size.toStringAsFixed(0),
          //           style: TextStyle(fontSize: 25),
          //         ),
          //       ),
          //       InkWell(
          //         onTap: () => setState(() => size += 50),
          //         child: AnimatedContainer(
          //           duration: Duration(milliseconds: 300),
          //           width: size,
          //           height: size,
          //           color: switch (size) {
          //             50 => Colors.red,
          //             100 => Colors.green,
          //             150 => Colors.amber,
          //             200 => Colors.pink,
          //             _ => Colors.blue,
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
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
