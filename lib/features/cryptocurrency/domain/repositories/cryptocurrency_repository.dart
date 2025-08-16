import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/cryptocurrency.dart';

abstract class CryptocurrencyRepository {
  Future<Either<Failure, List<Cryptocurrency>>> getTopCryptocurrencies();
  Future<Either<Failure, List<Cryptocurrency>>> searchCryptocurrencies(
    String query,
  );
  Future<Either<Failure, Cryptocurrency>> getCryptocurrencyDetails(String id);
  Future<Either<Failure, List<Cryptocurrency>>> getFavoriteCryptocurrencies();
  Future<Either<Failure, void>> addToFavorites(Cryptocurrency cryptocurrency);
  Future<Either<Failure, void>> removeFromFavorites(String id);
  Future<Either<Failure, bool>> isFavorite(String id);
}
