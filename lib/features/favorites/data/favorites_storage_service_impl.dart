import 'package:fake_store_lyqx/features/favorites/data/favorites_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteStorageServiceImpl implements FavoriteStorageService {
  FavoriteStorageServiceImpl({required SharedPreferences sharedPreferences})
    : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  String _getFavoritesKey(int userId) => 'favorite_products_$userId';

  @override
  Future<void> saveFavorites({
    required List<int> ids,
    required int userId,
  }) async {
    final stringIds = ids.map((id) => id.toString()).toList();
    await _sharedPreferences.setStringList(_getFavoritesKey(userId), stringIds);
  }

  @override
  Future<List<int>> getFavorites({required int userId}) async {
    final stringIds = _sharedPreferences.getStringList(
      _getFavoritesKey(userId),
    );
    if (stringIds == null) {
      return [];
    }
    return stringIds.map(int.parse).toList();
  }
}
