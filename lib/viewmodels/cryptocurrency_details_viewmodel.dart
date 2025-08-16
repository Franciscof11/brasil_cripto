import 'package:flutter/foundation.dart';

import '../models/cryptocurrency.dart';
import '../services/cryptocurrency_service.dart';
import '../services/favorites_service.dart';

class CryptocurrencyDetailsViewModel extends ChangeNotifier {
  final CryptocurrencyService _cryptocurrencyService;
  final FavoritesService _favoritesService;

  CryptocurrencyDetailsViewModel({
    required CryptocurrencyService cryptocurrencyService,
    required FavoritesService favoritesService,
  }) : _cryptocurrencyService = cryptocurrencyService,
       _favoritesService = favoritesService;

  Cryptocurrency? _cryptocurrency;
  bool _isLoading = false;
  bool _isFavorite = false;
  String? _error;

  Cryptocurrency? get cryptocurrency => _cryptocurrency;
  bool get isLoading => _isLoading;
  bool get isFavorite => _isFavorite;
  String? get error => _error;

  Future<void> loadCryptocurrencyDetails(String cryptoId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _cryptocurrency = await _cryptocurrencyService.getCryptocurrencyDetails(
        cryptoId,
      );
      _isFavorite = await _favoritesService.isFavorite(cryptoId);
      _error = null;
    } catch (e) {
      _error = e.toString();
      _cryptocurrency = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleFavorite() async {
    if (_cryptocurrency == null) return;

    try {
      await _favoritesService.toggleFavorite(_cryptocurrency!);
      _isFavorite = !_isFavorite;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> refresh(String cryptoId) async {
    await loadCryptocurrencyDetails(cryptoId);
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
