import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/cryptocurrency.dart';
import '../repositories/cryptocurrency_repository.dart';

class GetFavorites {
  final CryptocurrencyRepository repository;

  GetFavorites(this.repository);

  Future<Either<Failure, List<Cryptocurrency>>> call() async {
    return await repository.getFavoriteCryptocurrencies();
  }
}

class AddToFavorites {
  final CryptocurrencyRepository repository;

  AddToFavorites(this.repository);

  Future<Either<Failure, void>> call(Cryptocurrency cryptocurrency) async {
    return await repository.addToFavorites(cryptocurrency);
  }
}

class RemoveFromFavorites {
  final CryptocurrencyRepository repository;

  RemoveFromFavorites(this.repository);

  Future<Either<Failure, void>> call(String id) async {
    if (id.trim().isEmpty) {
      return const Left(InvalidInputFailure('ID cannot be empty'));
    }
    return await repository.removeFromFavorites(id);
  }
}

class CheckIsFavorite {
  final CryptocurrencyRepository repository;

  CheckIsFavorite(this.repository);

  Future<Either<Failure, bool>> call(String id) async {
    if (id.trim().isEmpty) {
      return const Left(InvalidInputFailure('ID cannot be empty'));
    }
    return await repository.isFavorite(id);
  }
}
