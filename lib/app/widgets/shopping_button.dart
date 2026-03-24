import 'package:flutter/material.dart';

class ShoppingButton extends StatelessWidget {
  final void Function()? onPressed;
  final int count;

  const ShoppingButton({super.key, required this.count, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Badge.count(
        count: count,
        isLabelVisible: (count > 0) ? true : false,
        offset: Offset(-5, 5),
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(Icons.shopping_cart),
        ),
      ),
    );
  }
}
