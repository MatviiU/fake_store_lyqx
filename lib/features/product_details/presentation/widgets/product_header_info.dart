import 'package:fake_store_lyqx/features/home/data/repository/models/product_entity.dart';
import 'package:flutter/material.dart';

class ProductHeaderInfo extends StatelessWidget {
  const ProductHeaderInfo({required this.product, super.key});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.title,
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w600,
            fontSize: 24,
            color: Colors.black.withValues(alpha: 0.75),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          product.category,
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontSize: 14,
            color: Colors.black.withValues(alpha: 0.5),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(Icons.star, size: 12, color: Colors.black),
            const SizedBox(width: 4),
            Text(
              '${product.rate}',
              style: const TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF303539),
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '${product.count} Reviews',
              style: const TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFFA6A6AA),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
