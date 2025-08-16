import 'package:hive/hive.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/cryptocurrency_model.dart';

abstract class CryptocurrencyLocalDataSource {
  Future<List<CryptocurrencyModel>> getFavoriteCryptocurrencies();
  Future<void> addToFavorites(CryptocurrencyModel cryptocurrency);
  Future<void> removeFromFavorites(String id);
  Future<bool> isFavorite(String id);
}

class CryptocurrencyLocalDataSourceImpl
    implements CryptocurrencyLocalDataSource {
  static const String favoritesBoxName = 'favorites';

  Future<Box<CryptocurrencyModel>> get _favoritesBox async {
    if (!Hive.isBoxOpen(favoritesBoxName)) {
      return await Hive.openBox<CryptocurrencyModel>(favoritesBoxName);
    }
    return Hive.box<CryptocurrencyModel>(favoritesBoxName);
  }

  @override
  Future<List<CryptocurrencyModel>> getFavoriteCryptocurrencies() async {
    try {
      final box = await _favoritesBox;
      return box.values.toList();
    } catch (e) {
      throw CacheException('Failed to load favorites: ${e.toString()}');
    }
  }

  @override
  Future<void> addToFavorites(CryptocurrencyModel cryptocurrency) async {
    try {
      final box = await _favoritesBox;
      await box.put(cryptocurrency.id, cryptocurrency);
    } catch (e) {
      throw CacheException('Failed to add to favorites: ${e.toString()}');
    }
  }

  @override
  Future<void> removeFromFavorites(String id) async {
    try {
      final box = await _favoritesBox;
      await box.delete(id);
    } catch (e) {
      throw CacheException('Failed to remove from favorites: ${e.toString()}');
    }
  }

  @override
  Future<bool> isFavorite(String id) async {
    try {
      final box = await _favoritesBox;
      return box.containsKey(id);
    } catch (e) {
      throw CacheException('Failed to check favorite status: ${e.toString()}');
    }
  }
}
