import 'package:fake_store_lyqx/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:fake_store_lyqx/features/favorites/presentation/cubit/favorites_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({required this.productId, super.key});

  final int productId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        var isFavorite = false;

        if (state is FavoritesLoaded) {
          isFavorite = state.favoritesIds.contains(productId);
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SizedBox(
            width: 24,
            height: 24,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? const Color(0xFFEB4335) : null,
                size: 20,
              ),
              onPressed: () {
                if (isFavorite) {
                  context.read<FavoritesCubit>().removeFavorite(
                    productId: productId,
                  );
                } else {
                  context.read<FavoritesCubit>().addFavorite(
                    productId: productId,
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}
