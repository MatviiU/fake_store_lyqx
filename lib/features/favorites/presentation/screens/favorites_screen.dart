import 'package:fake_store_lyqx/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:fake_store_lyqx/features/favorites/presentation/cubit/favorites_state.dart';
import 'package:fake_store_lyqx/features/favorites/presentation/widgets/favorites_header.dart';
import 'package:fake_store_lyqx/features/favorites/presentation/widgets/favorites_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        return switch (state) {
          FavoritesInitial() || FavoritesLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
          FavoritesLoaded() => SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FavoritesHeader(),
                  const SizedBox(height: 30),
                  if (state.products.isEmpty)
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Your favorites is empty',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ),
                    ),
                  Expanded(
                    child: FavoritesListWidget(products: state.products),
                  ),
                ],
              ),
            ),
          ),
          FavoritesError() => Center(child: Text(state.message)),
        };
      },
    );
  }
}
