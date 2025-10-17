import 'package:fake_store_lyqx/core/navigation/screen_names.dart';
import 'package:fake_store_lyqx/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:fake_store_lyqx/features/cart/presentation/cubit/cart_state.dart';
import 'package:fake_store_lyqx/features/favorites/presentation/widgets/favorite_button.dart';
import 'package:fake_store_lyqx/features/home/data/models/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FavoritesListItem extends StatelessWidget {
  const FavoritesListItem({required this.product, super.key});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: () {
        context.pushNamed(
          ScreenNames.productDetails,
          extra: product,
          pathParameters: {'productId': product.id.toString()},
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.network(
                product.image,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(child: Icon(Icons.error));
                },
              ),
            ),
            const SizedBox(width: 16),

            // --- Інформація про товар та кнопки ---
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // Розміщує кнопку внизу
                children: [
                  // Верхня частина (назва, ціна, кнопка "улюблене")
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              product.title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          FavoriteButton(productId: product.id),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      var inCart = false;
                      if (state is CartLoaded) {
                        inCart = state.items.any(
                          (item) => item.product.id == product.id,
                        );
                      }

                      return ElevatedButton(
                        onPressed: inCart
                            ? null
                            : () => context.read<CartCubit>().addItem(product),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: inCart ? Colors.black : Colors.white,
                          foregroundColor: inCart ? Colors.white : Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          minimumSize: const Size(0, 36),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (inCart) ...[
                              const Icon(Icons.check, size: 16),
                              const SizedBox(width: 8),
                            ],
                            Text(
                              inCart ? 'In Cart' : 'Add to cart',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: 'Urbanist',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
