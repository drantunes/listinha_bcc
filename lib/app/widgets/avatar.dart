import 'package:flutter/material.dart';
import 'package:listinha/app/configs/assets.dart';

class Avatar extends StatelessWidget {
  const Avatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: CircleAvatar(
        backgroundImage: AssetImage(Assets.profile),
      ),
    );
  }
}
