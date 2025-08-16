import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_top_cryptocurrencies.dart';
import '../../domain/usecases/search_cryptocurrencies.dart';
import 'cryptocurrency_state.dart';

class CryptocurrencyCubit extends Cubit<CryptocurrencyState> {
  final GetTopCryptocurrencies getTopCryptocurrencies;
  final SearchCryptocurrencies searchCryptocurrencies;

  CryptocurrencyCubit({
    required this.getTopCryptocurrencies,
    required this.searchCryptocurrencies,
  }) : super(CryptocurrencyInitial());

  Future<void> loadTopCryptocurrencies() async {
    emit(CryptocurrencyLoading());

    final result = await getTopCryptocurrencies();

    result.fold((failure) => emit(CryptocurrencyError(failure.message)), (
      cryptocurrencies,
    ) {
      if (cryptocurrencies.isEmpty) {
        emit(const CryptocurrencyEmpty('Nenhuma criptomoeda encontrada'));
      } else {
        emit(CryptocurrencyLoaded(cryptocurrencies));
      }
    });
  }

  Future<void> searchCrypto(String query) async {
    emit(CryptocurrencyLoading());

    final result = await searchCryptocurrencies(query);

    result.fold((failure) => emit(CryptocurrencyError(failure.message)), (
      cryptocurrencies,
    ) {
      if (cryptocurrencies.isEmpty) {
        emit(const CryptocurrencyEmpty('Nenhuma criptomoeda encontrada'));
      } else {
        emit(CryptocurrencyLoaded(cryptocurrencies));
      }
    });
  }

  void clearSearch() {
    loadTopCryptocurrencies();
  }
}
