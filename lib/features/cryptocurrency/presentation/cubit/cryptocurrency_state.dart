import 'package:equatable/equatable.dart';

import '../../domain/entities/cryptocurrency.dart';

abstract class CryptocurrencyState extends Equatable {
  const CryptocurrencyState();

  @override
  List<Object> get props => [];
}

class CryptocurrencyInitial extends CryptocurrencyState {}

class CryptocurrencyLoading extends CryptocurrencyState {}

class CryptocurrencyLoaded extends CryptocurrencyState {
  final List<Cryptocurrency> cryptocurrencies;

  const CryptocurrencyLoaded(this.cryptocurrencies);

  @override
  List<Object> get props => [cryptocurrencies];
}

class CryptocurrencyError extends CryptocurrencyState {
  final String message;

  const CryptocurrencyError(this.message);

  @override
  List<Object> get props => [message];
}

class CryptocurrencyEmpty extends CryptocurrencyState {
  final String message;

  const CryptocurrencyEmpty(this.message);

  @override
  List<Object> get props => [message];
}
