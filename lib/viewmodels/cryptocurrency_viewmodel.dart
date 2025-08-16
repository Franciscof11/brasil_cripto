import 'package:flutter/foundation.dart';

import '../models/cryptocurrency.dart';
import '../services/cryptocurrency_service.dart';

class CryptocurrencyViewModel extends ChangeNotifier {
  final CryptocurrencyService _cryptocurrencyService;

  CryptocurrencyViewModel({
    required CryptocurrencyService cryptocurrencyService,
  }) : _cryptocurrencyService = cryptocurrencyService;

  List<Cryptocurrency> _cryptocurrencies = [];
  List<Cryptocurrency> _searchResults = [];
  bool _isLoading = false;
  bool _isSearching = false;
  String? _error;
  String _searchQuery = '';

  List<Cryptocurrency> get cryptocurrencies => _cryptocurrencies;
  List<Cryptocurrency> get searchResults => _searchResults;
  bool get isLoading => _isLoading;
  bool get isSearching => _isSearching;
  String? get error => _error;
  String get searchQuery => _searchQuery;

  bool get hasSearchResults =>
      _searchQuery.isNotEmpty && _searchResults.isNotEmpty;
  bool get showEmptySearch =>
      _searchQuery.isNotEmpty && _searchResults.isEmpty && !_isSearching;

  Future<void> loadTopCryptocurrencies() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _cryptocurrencies = await _cryptocurrencyService.getTopCryptocurrencies();
      _error = null;
    } catch (e) {
      _error = e.toString();
      _cryptocurrencies = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchCryptocurrencies(String query) async {
    _searchQuery = query;

    if (query.isEmpty) {
      _searchResults = [];
      _isSearching = false;
      notifyListeners();
      return;
    }

    _isSearching = true;
    _error = null;
    notifyListeners();

    try {
      _searchResults = await _cryptocurrencyService.searchCryptocurrencies(
        query,
      );
      _error = null;
    } catch (e) {
      _error = e.toString();
      _searchResults = [];
    } finally {
      _isSearching = false;
      notifyListeners();
    }
  }

  void clearSearch() {
    _searchQuery = '';
    _searchResults = [];
    _isSearching = false;
    notifyListeners();
  }

  Future<void> refresh() async {
    await loadTopCryptocurrencies();
  }
}
