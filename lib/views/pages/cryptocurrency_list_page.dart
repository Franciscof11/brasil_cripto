import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/cryptocurrency_viewmodel.dart';
import '../../viewmodels/favorites_viewmodel.dart';
import '../widgets/cryptocurrency_list_item.dart';
import '../widgets/loading_shimmer.dart';
import '../widgets/search_bar_widget.dart';

class CryptocurrencyListPage extends StatefulWidget {
  const CryptocurrencyListPage({super.key});

  @override
  State<CryptocurrencyListPage> createState() => _CryptocurrencyListPageState();
}

class _CryptocurrencyListPageState extends State<CryptocurrencyListPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CryptocurrencyViewModel>().loadTopCryptocurrencies();
      context.read<FavoritesViewModel>().loadFavorites();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Brasil Cripto'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Consumer2<CryptocurrencyViewModel, FavoritesViewModel>(
        builder: (context, cryptoViewModel, favoritesViewModel, child) {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: SearchBarWidget(
                    controller: _searchController,
                    onChanged: cryptoViewModel.searchCryptocurrencies,
                    onClear: () {
                      _searchController.clear();
                      cryptoViewModel.clearSearch();
                    },
                    isSearching: cryptoViewModel.searchQuery.isNotEmpty,
                  ),
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: cryptoViewModel.refresh,
                  child: _buildContent(cryptoViewModel, favoritesViewModel),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContent(
    CryptocurrencyViewModel cryptoViewModel,
    FavoritesViewModel favoritesViewModel,
  ) {
    if (cryptoViewModel.isLoading) {
      return const LoadingShimmer();
    }

    if (cryptoViewModel.error != null) {
      return _buildErrorWidget(cryptoViewModel);
    }

    if (cryptoViewModel.showEmptySearch) {
      return _buildEmptySearchWidget();
    }

    final cryptocurrencies = cryptoViewModel.hasSearchResults
        ? cryptoViewModel.searchResults
        : cryptoViewModel.cryptocurrencies;

    if (cryptocurrencies.isEmpty) {
      return _buildEmptyWidget();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: cryptocurrencies.length,
      itemBuilder: (context, index) {
        final crypto = cryptocurrencies[index];
        final isFavorite = favoritesViewModel.isFavorite(crypto.id);
        return CryptocurrencyListItem(
          cryptocurrency: crypto,
          isFavorite: isFavorite,
          onTap: () {
            Navigator.pushNamed(context, '/details', arguments: crypto.id);
          },
          onFavoriteToggle: () {
            favoritesViewModel.toggleFavorite(crypto);
          },
        );
      },
    );
  }

  Widget _buildErrorWidget(CryptocurrencyViewModel viewModel) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[400]),
            const SizedBox(height: 16),
            Text(
              'Erro ao carregar dados',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              viewModel.error ?? 'Erro desconhecido',
              style: TextStyle(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: viewModel.refresh,
              child: const Text('Tentar Novamente'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptySearchWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Nenhum resultado encontrado',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Tente pesquisar por outro termo',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.currency_bitcoin, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Nenhuma criptomoeda encontrada',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Verifique sua conexão com a internet',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
