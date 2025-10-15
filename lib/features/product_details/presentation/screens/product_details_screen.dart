import 'package:fake_store_lyqx/features/home/data/models/product_entity.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({required this.product, super.key});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              //here must be favorite func
            },
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.favorite_border, size: 20),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 250,
                        height: 250,
                        padding: const EdgeInsets.all(8),
                        child: Image.network(
                          product.image,
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(child: Icon(Icons.error));
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),
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
                    const SizedBox(height: 12),
                    Column(
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
                          product.description,
                          style: const TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF3A3A3A),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: const Color(0xFFFFE8B2),
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Price',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF616161),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '\$${product.price}',
                      style: const TextStyle(
                        color: Color(0xFF3A3A3A),
                        fontFamily: 'Lora',
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    //here must be add to cart func
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E1E1E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 24,
                    ),
                    child: Text(
                      'Add to cart',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
