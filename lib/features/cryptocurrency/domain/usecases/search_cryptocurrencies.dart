import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/cryptocurrency.dart';
import '../repositories/cryptocurrency_repository.dart';

class SearchCryptocurrencies {
  final CryptocurrencyRepository repository;

  SearchCryptocurrencies(this.repository);

  Future<Either<Failure, List<Cryptocurrency>>> call(String query) async {
    if (query.trim().isEmpty) {
      return const Left(InvalidInputFailure('Query cannot be empty'));
    }
    return await repository.searchCryptocurrencies(query);
  }
}
