import 'package:flutter/material.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({required this.description, super.key});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            color: Color(0xFF616161),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(
            fontFamily: 'Urbanist',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF3A3A3A),
          ),
        ),
      ],
    );
  }
}
