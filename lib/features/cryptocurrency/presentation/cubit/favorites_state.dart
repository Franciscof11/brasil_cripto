import 'package:equatable/equatable.dart';

import '../../domain/entities/cryptocurrency.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<Cryptocurrency> favorites;

  const FavoritesLoaded(this.favorites);

  @override
  List<Object> get props => [favorites];
}

class FavoritesError extends FavoritesState {
  final String message;

  const FavoritesError(this.message);

  @override
  List<Object> get props => [message];
}

class FavoritesEmpty extends FavoritesState {
  final String message;

  const FavoritesEmpty(this.message);

  @override
  List<Object> get props => [message];
}

class FavoriteActionSuccess extends FavoritesState {
  final String message;

  const FavoriteActionSuccess(this.message);

  @override
  List<Object> get props => [message];
}
