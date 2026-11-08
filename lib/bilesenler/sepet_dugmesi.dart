import 'package:flutter/material.dart';
import '../modeller/sepet.dart';

class SepetDugmesi extends StatelessWidget {
  const SepetDugmesi({super.key, required this.sepet});
  final Sepet sepet;
  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: sepet,
    builder: (context, _) => IconButton(
      tooltip: 'Sepetim',
      onPressed: () => Navigator.pushNamed(context, '/sepet'),
      icon: Badge(
        isLabelVisible: sepet.adet > 0,
        label: Text('${sepet.adet}'),
        child: const Icon(Icons.shopping_bag_outlined),
      ),
    ),
  );
}
