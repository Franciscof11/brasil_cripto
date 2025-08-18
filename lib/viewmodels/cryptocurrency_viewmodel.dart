import 'dart:async';

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
  String? _searchError;
  String _searchQuery = '';
  Timer? _debounceTimer;

  List<Cryptocurrency> get cryptocurrencies => _cryptocurrencies;
  List<Cryptocurrency> get searchResults => _searchResults;
  bool get isLoading => _isLoading;
  bool get isSearching => _isSearching;
  String? get error => _searchQuery.isNotEmpty ? _searchError : _error;
  String get searchQuery => _searchQuery;

  bool get hasSearchResults =>
      _searchQuery.isNotEmpty && _searchResults.isNotEmpty;
  bool get showEmptySearch =>
      _searchQuery.isNotEmpty &&
      _searchResults.isEmpty &&
      !_isSearching &&
      _searchError == null;

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

  void searchCryptocurrencies(String query) {
    _searchQuery = query;

    _debounceTimer?.cancel();

    if (query.isEmpty) {
      _searchResults = [];
      _searchError = null;
      _isSearching = false;
      notifyListeners();
      return;
    }

    _searchError = null;
    _isSearching = true;
    notifyListeners();

    _debounceTimer = Timer(const Duration(milliseconds: 200), () {
      _performSearch(query);
    });
  }

  void _performSearch(String query) {
    try {
      final lowercaseQuery = query.toLowerCase();

      _searchResults = _cryptocurrencies.where((crypto) {
        final name = crypto.name.toLowerCase();
        final symbol = crypto.symbol.toLowerCase();
        final id = crypto.id.toLowerCase();

        return name.contains(lowercaseQuery) ||
            symbol.contains(lowercaseQuery) ||
            id.contains(lowercaseQuery) ||
            (crypto.marketCapRank != null &&
                crypto.marketCapRank.toString().contains(query));
      }).toList();

      _searchResults.sort((a, b) {
        final aName = a.name.toLowerCase();
        final aSymbol = a.symbol.toLowerCase();
        final bName = b.name.toLowerCase();
        final bSymbol = b.symbol.toLowerCase();

        final aSymbolExact = aSymbol == lowercaseQuery;
        final bSymbolExact = bSymbol == lowercaseQuery;
        if (aSymbolExact && !bSymbolExact) return -1;
        if (bSymbolExact && !aSymbolExact) return 1;

        final aNameStarts = aName.startsWith(lowercaseQuery);
        final bNameStarts = bName.startsWith(lowercaseQuery);
        if (aNameStarts && !bNameStarts) return -1;
        if (bNameStarts && !aNameStarts) return 1;

        final aSymbolStarts = aSymbol.startsWith(lowercaseQuery);
        final bSymbolStarts = bSymbol.startsWith(lowercaseQuery);
        if (aSymbolStarts && !bSymbolStarts) return -1;
        if (bSymbolStarts && !aSymbolStarts) return 1;

        if (a.marketCapRank != null && b.marketCapRank != null) {
          return a.marketCapRank!.compareTo(b.marketCapRank!);
        }

        return 0;
      });

      _searchError = null;
    } catch (e) {
      _searchError = 'Erro na busca local: ${e.toString()}';
      _searchResults = [];
    } finally {
      if (_searchQuery == query) {
        _isSearching = false;
        notifyListeners();
      }
    }
  }

  void clearSearch() {
    _debounceTimer?.cancel();
    _searchQuery = '';
    _searchResults = [];
    _searchError = null;
    _isSearching = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  Future<void> refresh() async {
    await loadTopCryptocurrencies();
  }
}
