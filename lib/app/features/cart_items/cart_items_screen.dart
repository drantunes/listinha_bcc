import 'package:flutter/material.dart';
import 'package:listinha/app/repositories/products_repository.dart';

class CartItemsScreen extends StatefulWidget {
  final ProductsRepository productsRepository;
  final void Function() update;

  const CartItemsScreen({
    super.key,
    required this.productsRepository,
    required this.update,
  });

  @override
  State<CartItemsScreen> createState() => _CartItemsScreenState();
}

class _CartItemsScreenState extends State<CartItemsScreen> {
  int totalItems = 0;
  double oldValue = 0;
  double currentValue = 0;
  double checked = 0;

  @override
  void initState() {
    super.initState();
    totalItems = widget.productsRepository.cartItems.length;
  }

  void changeProgress() {
    checked = checked + 1;
    oldValue = currentValue;
    currentValue = checked == 0 ? 0 : checked / totalItems;
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = widget.productsRepository.cartItems;
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Items'),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.close),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Stack(
              alignment: Alignment.center,
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: oldValue, end: currentValue),
                  duration: Duration(milliseconds: 400),
                  builder: (context, value, _) {
                    return CircularProgressIndicator(
                      backgroundColor: Colors.grey[200],
                      value: value,
                    );
                  },
                ),
                Text(
                  (totalItems - checked).toStringAsFixed(0),
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
      body: (cartItems.isEmpty)
          ? Center(
              child: Text('Não há items no carrinho'),
            )
          : ListView.separated(
              itemBuilder: (context, index) => ListTile(
                leading: Checkbox(
                  value: false,
                  onChanged: (val) {
                    setState(() {
                      widget.productsRepository.toggleCartItem(cartItems[index].product);
                      widget.update();
                      changeProgress();
                    });
                  },
                ),
                title: Text(cartItems[index].product.title),
                trailing: SizedBox(
                  width: 140,
                  child: Transform.scale(
                    scale: .7,
                    child: Row(
                      children: [
                        IconButton.filledTonal(
                          onPressed: () {
                            setState(() {
                              widget.productsRepository.decrease(cartItems[index]);
                            });
                          },
                          icon: Icon(Icons.remove),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            cartItems[index].amount.toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        IconButton.filledTonal(
                          onPressed: () {
                            setState(() {
                              widget.productsRepository.increase(cartItems[index]);
                            });
                          },
                          icon: Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              separatorBuilder: (_, _) => Divider(),
              itemCount: cartItems.length,
            ),
    );
  }
}
