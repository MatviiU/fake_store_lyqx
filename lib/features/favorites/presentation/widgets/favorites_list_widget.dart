import 'package:fake_store_lyqx/features/favorites/presentation/widgets/favorites_list_item.dart';
import 'package:fake_store_lyqx/features/home/data/models/product_entity.dart';
import 'package:flutter/material.dart';

class FavoritesListWidget extends StatelessWidget {
  const FavoritesListWidget({required this.products, super.key});

  final List<ProductEntity> products;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: products.length,
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemBuilder: (context, index) {
        final product = products[index];
        return FavoritesListItem(product: product);
      },
    );
  }
}
