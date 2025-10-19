import 'package:fake_store_lyqx/features/favorites/presentation/widgets/favorite_button.dart';
import 'package:fake_store_lyqx/features/home/data/repository/models/product_entity.dart';
import 'package:fake_store_lyqx/features/product_details/presentation/widgets/product_action_bar.dart';
import 'package:fake_store_lyqx/features/product_details/presentation/widgets/product_description.dart';
import 'package:fake_store_lyqx/features/product_details/presentation/widgets/product_header_info.dart';
import 'package:fake_store_lyqx/features/product_details/presentation/widgets/product_image.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({required this.product, super.key});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [FavoriteButton(productId: product.id)]),
      body: Column(
        children: [
          Expanded(
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductImage(image: product.image),
                    const SizedBox(height: 100),
                    ProductHeaderInfo(product: product),
                    const SizedBox(height: 12),
                    ProductDescription(description: product.description),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ),
          ProductActionBar(product: product),
        ],
      ),
    );
  }
}
