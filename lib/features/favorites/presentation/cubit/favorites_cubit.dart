import 'package:fake_store_lyqx/features/favorites/data/favorites_storage_service.dart';
import 'package:fake_store_lyqx/features/favorites/presentation/cubit/favorites_state.dart';
import 'package:fake_store_lyqx/features/home/data/models/product_entity.dart';
import 'package:fake_store_lyqx/features/home/data/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit({
    required FavoriteStorageService favoriteStorageService,
    required ProductRepository productRepository,
  }) : _favoriteStorageService = favoriteStorageService,
       _productRepository = productRepository,
       super(FavoritesInitial());

  final FavoriteStorageService _favoriteStorageService;
  final ProductRepository _productRepository;

  int? _currentUserId;

  Future<void> getFavorites({required int userId}) async {
    if (state is FavoritesLoaded && _currentUserId == userId) {
      return;
    }
    emit(FavoritesLoading());
    try {
      _currentUserId = userId;
      final favoritesIds = await _favoriteStorageService.getFavorites(
        userId: userId,
      );
      final products = await _productRepository.getProductsByIds(favoritesIds);
      emit(FavoritesLoaded(favoritesIds: favoritesIds, products: products));
    } catch (e) {
      emit(FavoritesError(message: e.toString()));
    }
  }

  Future<void> saveFavorites({
    required int userId,
    required List<int> favoritesIds,
  }) async {
    try {
      await _favoriteStorageService.saveFavorites(
        ids: favoritesIds,
        userId: userId,
      );
    } catch (e) {
      emit(FavoritesError(message: e.toString()));
    }
  }

  Future<void> addFavorite({required int productId}) async {
    if (state is! FavoritesLoaded || _currentUserId == null) return;
    final currentState = state as FavoritesLoaded;
    if (currentState.favoritesIds.contains(productId)) {
      return;
    }
    try {
      final products = await _productRepository.getProductsByIds([productId]);
      if (products.isEmpty) {
        return;
      }
      final newProduct = products.first;
      final newFavoriteIds = [...currentState.favoritesIds, productId];
      final newProducts = [...currentState.products, newProduct];
      await _updateAndSaveFavorites(
        products: newProducts,
        favoritesIds: newFavoriteIds,
      );
    } catch (e) {
      emit(FavoritesError(message: e.toString()));
    }
  }

  Future<void> removeFavorite({required int productId}) async {
    if (state is! FavoritesLoaded || _currentUserId == null) return;
    final currentState = state as FavoritesLoaded;

    final newFavoriteIds = currentState.favoritesIds
        .where((id) => id != productId)
        .toList();
    final newProducts = currentState.products
        .where((product) => product.id != productId)
        .toList();
    await _updateAndSaveFavorites(
      products: newProducts,
      favoritesIds: newFavoriteIds,
    );
  }

  Future<void> _updateAndSaveFavorites({
    required List<ProductEntity> products,
    required List<int> favoritesIds,
  }) async {
    emit(FavoritesLoaded(favoritesIds: favoritesIds, products: products));
    try {
      await _favoriteStorageService.saveFavorites(
        ids: favoritesIds,
        userId: _currentUserId!,
      );
    } catch (e) {
      emit(FavoritesError(message: e.toString()));
    }
  }

  void clearFavorites() {
    if (_currentUserId == null) return;
    _updateAndSaveFavorites(products: [], favoritesIds: []);
  }
}
