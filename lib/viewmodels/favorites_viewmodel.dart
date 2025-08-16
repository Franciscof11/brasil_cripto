import 'package:flutter/foundation.dart';

import '../models/cryptocurrency.dart';
import '../services/favorites_service.dart';

class FavoritesViewModel extends ChangeNotifier {
  final FavoritesService _favoritesService;

  FavoritesViewModel({required FavoritesService favoritesService})
    : _favoritesService = favoritesService;

  List<Cryptocurrency> _favorites = [];
  bool _isLoading = false;
  String? _error;

  List<Cryptocurrency> get favorites => _favorites;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isEmpty => _favorites.isEmpty && !_isLoading;

  Future<void> loadFavorites() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _favorites = await _favoritesService.getFavoriteCryptocurrencies();
      _error = null;
    } catch (e) {
      _error = e.toString();
      _favorites = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> removeFromFavorites(String cryptoId) async {
    try {
      await _favoritesService.removeFromFavorites(cryptoId);
      _favorites.removeWhere((crypto) => crypto.id == cryptoId);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> addToFavorites(Cryptocurrency cryptocurrency) async {
    try {
      await _favoritesService.addToFavorites(cryptocurrency);
      if (!_favorites.any((crypto) => crypto.id == cryptocurrency.id)) {
        _favorites.add(cryptocurrency);
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String cryptoId) async {
    try {
      return await _favoritesService.isFavorite(cryptoId);
    } catch (e) {
      return false;
    }
  }

  Future<void> toggleFavorite(Cryptocurrency cryptocurrency) async {
    try {
      final isCurrentlyFavorite = await _favoritesService.isFavorite(
        cryptocurrency.id,
      );
      if (isCurrentlyFavorite) {
        await removeFromFavorites(cryptocurrency.id);
      } else {
        await addToFavorites(cryptocurrency);
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    await loadFavorites();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
