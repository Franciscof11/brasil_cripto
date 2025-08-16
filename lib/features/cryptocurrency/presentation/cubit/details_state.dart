import 'package:equatable/equatable.dart';

import '../../domain/entities/cryptocurrency.dart';

abstract class DetailsState extends Equatable {
  const DetailsState();

  @override
  List<Object> get props => [];
}

class DetailsInitial extends DetailsState {}

class DetailsLoading extends DetailsState {}

class DetailsLoaded extends DetailsState {
  final Cryptocurrency cryptocurrency;
  final bool isFavorite;

  const DetailsLoaded(this.cryptocurrency, this.isFavorite);

  @override
  List<Object> get props => [cryptocurrency, isFavorite];
}

class DetailsError extends DetailsState {
  final String message;

  const DetailsError(this.message);

  @override
  List<Object> get props => [message];
}
