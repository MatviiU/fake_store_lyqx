import 'package:fake_store_lyqx/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:fake_store_lyqx/features/cart/presentation/cubit/cart_state.dart';
import 'package:fake_store_lyqx/features/cart/presentation/widgets/cart_header.dart';
import 'package:fake_store_lyqx/features/cart/presentation/widgets/cart_list_view.dart';
import 'package:fake_store_lyqx/features/cart/presentation/widgets/cart_total_section.dart';
import 'package:fake_store_lyqx/features/cart/presentation/widgets/empty_cart_view.dart';
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
                    const CartHeader(),
                    const SizedBox(height: 30),
                    if (state.items.isEmpty) const EmptyCartView(),
                    Expanded(child: CartListView(items: state.items)),
                    if (state.items.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      CartTotalSection(items: state.items),
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
}
