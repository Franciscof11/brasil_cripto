import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/cryptocurrency.dart';
import '../repositories/cryptocurrency_repository.dart';

class GetCryptocurrencyDetails {
  final CryptocurrencyRepository repository;

  GetCryptocurrencyDetails(this.repository);

  Future<Either<Failure, Cryptocurrency>> call(String id) async {
    if (id.trim().isEmpty) {
      return const Left(InvalidInputFailure('ID cannot be empty'));
    }
    return await repository.getCryptocurrencyDetails(id);
  }
}
