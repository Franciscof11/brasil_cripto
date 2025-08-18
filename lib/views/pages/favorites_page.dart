import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/favorites_viewmodel.dart';
import '../widgets/cryptocurrency_list_item.dart';
import '../widgets/theme_toggle_widget.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FavoritesViewModel>().loadFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
        actions: const [ThemeToggleWidget(), SizedBox(width: 8)],
      ),
      body: Consumer<FavoritesViewModel>(
        builder: (context, viewModel, child) {
          return RefreshIndicator(
            onRefresh: viewModel.refresh,
            child: _buildContent(viewModel),
          );
        },
      ),
    );
  }

  Widget _buildContent(FavoritesViewModel viewModel) {
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (viewModel.error != null) {
      return _buildErrorWidget(viewModel);
    }

    if (viewModel.isEmpty) {
      return _buildEmptyWidget();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: viewModel.favorites.length,
      itemBuilder: (context, index) {
        final crypto = viewModel.favorites[index];
        return CryptocurrencyListItem(
          cryptocurrency: crypto,
          isFavorite: true,
          onTap: () {
            Navigator.pushNamed(context, '/details', arguments: crypto.id);
          },
          onFavoriteToggle: () {
            viewModel.removeFromFavorites(crypto.id);
          },
        );
      },
    );
  }

  Widget _buildErrorWidget(FavoritesViewModel viewModel) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Erro ao carregar favoritos',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              viewModel.error ?? 'Erro desconhecido',
              style: Theme.of(context).textTheme.bodyMedium,
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

  Widget _buildEmptyWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 64,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(height: 16),
            Text(
              'Nenhum favorito ainda',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Adicione criptomoedas aos seus favoritos para vê-las aqui',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
