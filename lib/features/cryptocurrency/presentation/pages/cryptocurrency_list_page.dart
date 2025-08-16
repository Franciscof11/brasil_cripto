import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cryptocurrency_cubit.dart';
import '../cubit/cryptocurrency_state.dart';
import '../cubit/favorites_cubit.dart';
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
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    context.read<CryptocurrencyCubit>().loadTopCryptocurrencies();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (query.trim().isEmpty) {
      setState(() {
        _isSearching = false;
      });
      context.read<CryptocurrencyCubit>().clearSearch();
    } else {
      setState(() {
        _isSearching = true;
      });
      context.read<CryptocurrencyCubit>().searchCrypto(query);
    }
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _isSearching = false;
    });
    context.read<CryptocurrencyCubit>().clearSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'BrasilCripto',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SearchBarWidget(
                controller: _searchController,
                onChanged: _onSearchChanged,
                onClear: _clearSearch,
                isSearching: _isSearching,
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<CryptocurrencyCubit, CryptocurrencyState>(
              builder: (context, state) {
                if (state is CryptocurrencyLoading) {
                  return const LoadingShimmer();
                } else if (state is CryptocurrencyError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.red[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Erro ao carregar dados',
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
                            if (_isSearching) {
                              _onSearchChanged(_searchController.text);
                            } else {
                              context
                                  .read<CryptocurrencyCubit>()
                                  .loadTopCryptocurrencies();
                            }
                          },
                          child: const Text('Tentar Novamente'),
                        ),
                      ],
                    ),
                  );
                } else if (state is CryptocurrencyEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          state.message,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        if (_isSearching) ...[
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _clearSearch,
                            child: const Text('Limpar Busca'),
                          ),
                        ],
                      ],
                    ),
                  );
                } else if (state is CryptocurrencyLoaded) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      if (_isSearching) {
                        _onSearchChanged(_searchController.text);
                      } else {
                        context
                            .read<CryptocurrencyCubit>()
                            .loadTopCryptocurrencies();
                      }
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.cryptocurrencies.length,
                      itemBuilder: (context, index) {
                        final crypto = state.cryptocurrencies[index];
                        return CryptocurrencyListItem(
                          cryptocurrency: crypto,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/details',
                              arguments: crypto.id,
                            );
                          },
                          onFavoriteToggle: () {
                            context.read<FavoritesCubit>().addFavorite(crypto);
                          },
                        );
                      },
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
