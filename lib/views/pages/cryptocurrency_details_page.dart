import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/cryptocurrency_details_viewmodel.dart';
import '../widgets/info_card_widget.dart';
import '../widgets/price_chart_widget.dart';

class CryptocurrencyDetailsPage extends StatefulWidget {
  final String cryptoId;

  const CryptocurrencyDetailsPage({super.key, required this.cryptoId});

  @override
  State<CryptocurrencyDetailsPage> createState() =>
      _CryptocurrencyDetailsPageState();
}

class _CryptocurrencyDetailsPageState extends State<CryptocurrencyDetailsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CryptocurrencyDetailsViewModel>().loadCryptocurrencyDetails(
        widget.cryptoId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CryptocurrencyDetailsViewModel>(
        builder: (context, viewModel, child) {
          return switch (viewModel) {
            _ when viewModel.isLoading => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
            _ when viewModel.error != null => Scaffold(
              appBar: AppBar(title: const Text('Erro')),
              body: Center(
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
                      'Erro ao carregar detalhes',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      viewModel.error!,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        viewModel.loadCryptocurrencyDetails(widget.cryptoId);
                      },
                      child: const Text('Tentar Novamente'),
                    ),
                  ],
                ),
              ),
            ),
            _ when viewModel.cryptocurrency != null => _buildLoadedContent(
              viewModel,
            ),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }

  Widget _buildLoadedContent(CryptocurrencyDetailsViewModel viewModel) {
    final crypto = viewModel.cryptocurrency!;
    final isFavorite = viewModel.isFavorite;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 200,
          pinned: true,
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? Theme.of(context).scaffoldBackgroundColor
              : Theme.of(context).primaryColor,
          foregroundColor: Theme.of(context).brightness == Brightness.dark
              ? Theme.of(context).colorScheme.onSurface
              : Colors.white,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context).scaffoldBackgroundColor
                  : Theme.of(context).primaryColor,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (crypto.image != null)
                            CachedNetworkImage(
                              imageUrl: crypto.image!,
                              width: 48,
                              height: 48,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  crypto.name,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Theme.of(
                                            context,
                                          ).colorScheme.onSurface
                                        : Colors.white,
                                  ),
                                ),
                                Text(
                                  crypto.symbol.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color:
                                        Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Theme.of(context)
                                              .colorScheme
                                              .onSurface
                                              .withValues(alpha: 0.7)
                                        : Colors.white.withValues(alpha: 0.8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  crypto.formattedPrice,
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Theme.of(
                                            context,
                                          ).colorScheme.onSurface
                                        : Colors.white,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: crypto.isPriceIncreasing
                                        ? Colors.green
                                        : Colors.red,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    crypto.formattedPriceChange,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: viewModel.toggleFavorite,
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite
                    ? Colors.red
                    : (Theme.of(context).brightness == Brightness.dark
                          ? Theme.of(context).colorScheme.onSurface
                          : Colors.white),
              ),
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Gráfico de Preço (24h)',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        const PriceChartWidget(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Informações do Mercado',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: InfoCardWidget(
                        title: 'Market Cap',
                        value: crypto.formattedMarketCap,
                        icon: Icons.trending_up,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: InfoCardWidget(
                        title: 'Volume 24h',
                        value: crypto.formattedVolume,
                        icon: Icons.bar_chart,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: InfoCardWidget(
                        title: 'Máxima 24h',
                        value: crypto.high24h != null
                            ? '\$${crypto.high24h!.toStringAsFixed(2)}'
                            : '--',
                        icon: Icons.keyboard_arrow_up,
                        valueColor: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: InfoCardWidget(
                        title: 'Mínima 24h',
                        value: crypto.low24h != null
                            ? '\$${crypto.low24h!.toStringAsFixed(2)}'
                            : '--',
                        icon: Icons.keyboard_arrow_down,
                        valueColor: Colors.red,
                      ),
                    ),
                  ],
                ),
                if (crypto.marketCapRank != null) ...[
                  const SizedBox(height: 16),
                  InfoCardWidget(
                    title: 'Ranking de Market Cap',
                    value: '#${crypto.marketCapRank}',
                    icon: Icons.emoji_events,
                  ),
                ],
                if (crypto.description != null &&
                    crypto.description!.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  Text(
                    'Sobre ${crypto.name}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        crypto.description!,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge?.copyWith(height: 1.5),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
