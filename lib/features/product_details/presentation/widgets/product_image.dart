import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({required this.image, super.key});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 250,
        height: 250,
        padding: const EdgeInsets.all(8),
        child: Image.network(
          image,
          fit: BoxFit.contain,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return const Center(child: CircularProgressIndicator());
          },
          errorBuilder: (context, error, stackTrace) {
            return const Center(child: Icon(Icons.error));
          },
        ),
      ),
    );
  }
}
