import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final double price;
  final Image image;
  final Color backgroundColor;
  const ProductCard(
      {super.key,
      required this.title,
      required this.price,
      required this.image,
      required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
            maxLines: 1,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            '\$$price',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 175,
            child: Center(child: image),
          ),
        ],
      ),
    );
  }
}
