import 'package:fake_store_lyqx/features/cart/data/repository/models/cart_item_entity.dart';
import 'package:fake_store_lyqx/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:fake_store_lyqx/features/cart/presentation/cubit/cart_state.dart';
import 'package:fake_store_lyqx/features/cart/presentation/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 35),
              child: switch (state) {
                CartInitial() || CartLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),

                CartError() => Center(child: Text(state.message)),
                CartLoaded() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Cart',
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF252425),
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFffe7ab),
                              ),
                              child: Center(
                                child: IconButton(
                                  onPressed: () {
                                    //here must be logout func
                                  },
                                  icon: const Icon(
                                    size: 18,
                                    Icons.logout,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Logout',
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF3A3A3A),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    if (state.items.isEmpty)
                      const Expanded(
                        child: Center(
                          child: Text(
                            'Your cart is empty',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ),
                      ),
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          final item = state.items[index];
                          return Dismissible(
                            key: ValueKey(item.product.id),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              context.read<CartCubit>().updateQuantity(
                                productId: item.product.id,
                                newQuantity: 0,
                              );

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${item.product.title} removed from cart',
                                  ),
                                  action: SnackBarAction(
                                    label: 'UNDO',
                                    onPressed: () {
                                      context.read<CartCubit>().addItem(
                                        item.product,
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                            background: Container(
                              color: const Color(0xFFCC474E),
                              padding: const EdgeInsets.only(right: 20.0),
                              alignment: Alignment.centerRight,
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),

                            child: CartItem(
                              cartItemEntity: item,
                              onRemove: () =>
                                  context.read<CartCubit>().updateQuantity(
                                    productId: item.product.id,
                                    newQuantity: item.quantity - 1,
                                  ),
                              onAdd: () =>
                                  context.read<CartCubit>().updateQuantity(
                                    productId: item.product.id,
                                    newQuantity: item.quantity + 1,
                                  ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 24),
                        itemCount: state.items.length,
                      ),
                    ),
                    if (state.items.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      _buildTotalSection(context, state.items),
                    ],
                  ],
                ),
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildTotalSection(BuildContext context, List<CartItemEntity> items) {
    final totalPrice = items.fold(
      0.0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Cart total',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                color: Color(0xFF616161),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '\$${totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(width: 24),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              // Logic for proceeding to checkout
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E1E1E),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            ),
            child: const Text(
              'Checkout',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
