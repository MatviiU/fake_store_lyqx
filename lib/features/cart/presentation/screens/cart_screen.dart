import 'package:fake_store_lyqx/features/cart/data/repository/models/cart_item_entity.dart';
import 'package:fake_store_lyqx/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:fake_store_lyqx/features/cart/presentation/cubit/cart_state.dart';
import 'package:fake_store_lyqx/features/cart/presentation/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is CartDeleted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Cart deleted')));
          context.pop();
        }
      },
      builder: (context, state) {
        return switch (state) {
          CartInitial() ||
          CartLoading() ||
          CartDeleted() => const Center(child: CircularProgressIndicator()),
          CartLoaded() => Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 35,
                ),
                child: Column(
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
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          final item = state.items[index];
                          return CartItem(
                            cartItemEntity: item,
                            onRemove: () => _updateQuantity(
                              context: context,
                              cartId: state.cartId,
                              userId: state.userId,
                              item: item,
                              newQuantity: item.quantity - 1,
                            ),
                            onAdd: () => _updateQuantity(
                              context: context,
                              cartId: state.cartId,
                              userId: state.userId,
                              item: item,
                              newQuantity: item.quantity + 1,
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 24),
                        itemCount: state.items.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          CartError() => throw UnimplementedError(),
        };
      },
    );
  }

  void _updateQuantity({
    required BuildContext context,
    required int cartId,
    required int userId,
    required CartItemEntity item,
    required int newQuantity,
  }) {
    context.read<CartCubit>().updateItemQuantity(
      cartId: cartId,
      userId: userId,
      productId: item.product.id,
      newQuantity: newQuantity,
    );
  }
}
