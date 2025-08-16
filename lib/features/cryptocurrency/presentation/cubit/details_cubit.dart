import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_cryptocurrency_details.dart';
import '../../domain/usecases/manage_favorites.dart';
import 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  final GetCryptocurrencyDetails getCryptocurrencyDetails;
  final CheckIsFavorite checkIsFavorite;
  final AddToFavorites addToFavorites;
  final RemoveFromFavorites removeFromFavorites;

  DetailsCubit({
    required this.getCryptocurrencyDetails,
    required this.checkIsFavorite,
    required this.addToFavorites,
    required this.removeFromFavorites,
  }) : super(DetailsInitial());

  Future<void> loadCryptocurrencyDetails(String id) async {
    emit(DetailsLoading());

    final detailsResult = await getCryptocurrencyDetails(id);
    final favoriteResult = await checkIsFavorite(id);

    detailsResult.fold((failure) => emit(DetailsError(failure.message)), (
      cryptocurrency,
    ) {
      final isFav = favoriteResult.fold((failure) => false, (isFav) => isFav);
      emit(DetailsLoaded(cryptocurrency, isFav));
    });
  }

  Future<void> toggleFavorite() async {
    final currentState = state;
    if (currentState is DetailsLoaded) {
      final cryptocurrency = currentState.cryptocurrency;
      final isFavorite = currentState.isFavorite;

      if (isFavorite) {
        final result = await removeFromFavorites(cryptocurrency.id);
        result.fold(
          (failure) => emit(DetailsError(failure.message)),
          (_) => emit(DetailsLoaded(cryptocurrency, false)),
        );
      } else {
        final result = await addToFavorites(cryptocurrency);
        result.fold(
          (failure) => emit(DetailsError(failure.message)),
          (_) => emit(DetailsLoaded(cryptocurrency, true)),
        );
      }
    }
  }
}
