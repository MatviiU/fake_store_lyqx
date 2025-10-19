import 'package:fake_store_lyqx/features/home/data/repository/models/product_entity.dart';
import 'package:fake_store_lyqx/features/home/presentation/widgets/product_list_item.dart';
import 'package:flutter/material.dart';

class ProductListWidget extends StatelessWidget {
  const ProductListWidget({required this.products, super.key});

  final List<ProductEntity> products;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductListItem(product: product);
        },
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemCount: products.length,
      ),
    );
  }
}
