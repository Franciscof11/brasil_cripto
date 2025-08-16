import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/details_cubit.dart';
import '../cubit/details_state.dart';
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
    context.read<DetailsCubit>().loadCryptocurrencyDetails(widget.cryptoId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: BlocBuilder<DetailsCubit, DetailsState>(
        builder: (context, state) {
          if (state is DetailsLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is DetailsError) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Erro'),
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 64, color: Colors.red[400]),
                    const SizedBox(height: 16),
                    Text(
                      'Erro ao carregar detalhes',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.message,
                      style: TextStyle(color: Colors.grey[600]),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<DetailsCubit>().loadCryptocurrencyDetails(
                          widget.cryptoId,
                        );
                      },
                      child: const Text('Tentar Novamente'),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is DetailsLoaded) {
            final crypto = state.cryptocurrency;
            final isFavorite = state.isFavorite;

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 200,
                  pinned: true,
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Theme.of(context).primaryColor,
                            Theme.of(context).primaryColor.withOpacity(0.8),
                          ],
                        ),
                      ),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          crypto.name,
                                          style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          crypto.symbol.toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white.withOpacity(
                                              0.8,
                                            ),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          crypto.formattedPrice,
                                          style: const TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
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
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
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
                      onPressed: () {
                        context.read<DetailsCubit>().toggleFavorite();
                      },
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.white,
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
                        // Gráfico de preço (placeholder por enquanto)
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
                        // Informações detalhadas
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
                                style: TextStyle(
                                  height: 1.5,
                                  color: Colors.grey[700],
                                ),
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
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
