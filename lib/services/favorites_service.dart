import 'package:hive/hive.dart';

import '../models/cryptocurrency.dart';

class FavoritesService {
  static const String favoritesBoxName = 'favorites';

  Future<Box<Cryptocurrency>> get _favoritesBox async {
    if (!Hive.isBoxOpen(favoritesBoxName)) {
      return await Hive.openBox<Cryptocurrency>(favoritesBoxName);
    }
    return Hive.box<Cryptocurrency>(favoritesBoxName);
  }

  Future<List<Cryptocurrency>> getFavoriteCryptocurrencies() async {
    try {
      final box = await _favoritesBox;
      return box.values.toList();
    } catch (e) {
      throw Exception('Failed to load favorites: ${e.toString()}');
    }
  }

  Future<void> addToFavorites(Cryptocurrency cryptocurrency) async {
    try {
      final box = await _favoritesBox;
      await box.put(cryptocurrency.id, cryptocurrency);
    } catch (e) {
      throw Exception('Failed to add to favorites: ${e.toString()}');
    }
  }

  Future<void> removeFromFavorites(String id) async {
    try {
      final box = await _favoritesBox;
      await box.delete(id);
    } catch (e) {
      throw Exception('Failed to remove from favorites: ${e.toString()}');
    }
  }

  Future<bool> isFavorite(String id) async {
    try {
      final box = await _favoritesBox;
      return box.containsKey(id);
    } catch (e) {
      throw Exception('Failed to check favorite status: ${e.toString()}');
    }
  }

  Future<void> toggleFavorite(Cryptocurrency cryptocurrency) async {
    try {
      final isCurrentlyFavorite = await isFavorite(cryptocurrency.id);
      if (isCurrentlyFavorite) {
        await removeFromFavorites(cryptocurrency.id);
      } else {
        await addToFavorites(cryptocurrency);
      }
    } catch (e) {
      throw Exception('Failed to toggle favorite: ${e.toString()}');
    }
  }
}
