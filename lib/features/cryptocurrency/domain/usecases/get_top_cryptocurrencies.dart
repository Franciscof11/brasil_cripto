import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/cryptocurrency.dart';
import '../repositories/cryptocurrency_repository.dart';

class GetTopCryptocurrencies {
  final CryptocurrencyRepository repository;

  GetTopCryptocurrencies(this.repository);

  Future<Either<Failure, List<Cryptocurrency>>> call() async {
    return await repository.getTopCryptocurrencies();
  }
}
