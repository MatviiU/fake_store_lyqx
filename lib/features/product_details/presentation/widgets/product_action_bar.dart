import 'package:fake_store_lyqx/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:fake_store_lyqx/features/cart/presentation/cubit/cart_state.dart';
import 'package:fake_store_lyqx/features/home/data/repository/models/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductActionBar extends StatelessWidget {
  const ProductActionBar({required this.product, super.key});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  backgroundColor: inCart ? Colors.white : Colors.black,
                  foregroundColor: inCart ? Colors.black : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  minimumSize: const Size(0, 36),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 24,
                  ),
                  child: Text(
                    inCart ? 'In Cart' : 'Add to cart',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
