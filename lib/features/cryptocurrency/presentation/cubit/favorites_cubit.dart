import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/cryptocurrency.dart';
import '../../domain/usecases/manage_favorites.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final GetFavorites getFavorites;
  final AddToFavorites addToFavorites;
  final RemoveFromFavorites removeFromFavorites;
  final CheckIsFavorite checkIsFavorite;

  FavoritesCubit({
    required this.getFavorites,
    required this.addToFavorites,
    required this.removeFromFavorites,
    required this.checkIsFavorite,
  }) : super(FavoritesInitial());

  Future<void> loadFavorites() async {
    emit(FavoritesLoading());

    final result = await getFavorites();

    result.fold((failure) => emit(FavoritesError(failure.message)), (
      favorites,
    ) {
      if (favorites.isEmpty) {
        emit(const FavoritesEmpty('Nenhuma criptomoeda favorita ainda'));
      } else {
        emit(FavoritesLoaded(favorites));
      }
    });
  }

  Future<void> addFavorite(Cryptocurrency cryptocurrency) async {
    final result = await addToFavorites(cryptocurrency);

    result.fold((failure) => emit(FavoritesError(failure.message)), (_) {
      emit(const FavoriteActionSuccess('Adicionado aos favoritos!'));
      loadFavorites();
    });
  }

  Future<void> removeFavorite(String id) async {
    final result = await removeFromFavorites(id);

    result.fold((failure) => emit(FavoritesError(failure.message)), (_) {
      emit(const FavoriteActionSuccess('Removido dos favoritos!'));
      loadFavorites();
    });
  }

  Future<bool> isFavorite(String id) async {
    final result = await checkIsFavorite(id);

    return result.fold((failure) => false, (isFav) => isFav);
  }
}
