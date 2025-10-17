abstract interface class FavoriteStorageService {
  Future<void> saveFavorites({required List<int> ids, required int userId});

  Future<List<int>> getFavorites(int userId);

  Future<void> addFavorite({required int id, required int userId});

  Future<void> removeFavorite({required int id, required int userId});
}
