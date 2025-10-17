abstract interface class FavoriteStorageService {
  Future<void> saveFavorites({required List<int> ids, required int userId});

  Future<List<int>> getFavorites({required int userId});
}
