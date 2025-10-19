import 'package:fake_store_lyqx/features/cart/data/repository/models/cart_item_entity.dart';
import 'package:fake_store_lyqx/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:fake_store_lyqx/features/cart/presentation/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartListView extends StatelessWidget {
  const CartListView({required this.items, super.key});

  final List<CartItemEntity> items;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        final item = items[index];
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
                content: Text('${item.product.title} removed from cart'),
              ),
            );
          },
          background: Container(
            color: const Color(0xFFCC474E),
            padding: const EdgeInsets.only(right: 20.0),
            alignment: Alignment.centerRight,
            child: const Icon(Icons.delete, color: Colors.white),
          ),

          child: CartItem(
            cartItemEntity: item,
            onRemove: () => context.read<CartCubit>().updateQuantity(
              productId: item.product.id,
              newQuantity: item.quantity - 1,
            ),
            onAdd: () => context.read<CartCubit>().updateQuantity(
              productId: item.product.id,
              newQuantity: item.quantity + 1,
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 24),
      itemCount: items.length,
    );
  }
}
