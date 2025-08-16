import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/cryptocurrency.dart';
import '../../domain/repositories/cryptocurrency_repository.dart';
import '../datasources/cryptocurrency_local_datasource.dart';
import '../datasources/cryptocurrency_remote_datasource.dart';
import '../models/cryptocurrency_model.dart';

class CryptocurrencyRepositoryImpl implements CryptocurrencyRepository {
  final CryptocurrencyRemoteDataSource remoteDataSource;
  final CryptocurrencyLocalDataSource localDataSource;

  CryptocurrencyRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Cryptocurrency>>> getTopCryptocurrencies() async {
    try {
      final cryptocurrencies = await remoteDataSource.getTopCryptocurrencies();
      return Right(cryptocurrencies);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Cryptocurrency>>> searchCryptocurrencies(
    String query,
  ) async {
    try {
      final cryptocurrencies = await remoteDataSource.searchCryptocurrencies(
        query,
      );
      return Right(cryptocurrencies);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Cryptocurrency>> getCryptocurrencyDetails(
    String id,
  ) async {
    try {
      final cryptocurrency = await remoteDataSource.getCryptocurrencyDetails(
        id,
      );
      return Right(cryptocurrency);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Cryptocurrency>>>
  getFavoriteCryptocurrencies() async {
    try {
      final favorites = await localDataSource.getFavoriteCryptocurrencies();
      return Right(favorites);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> addToFavorites(
    Cryptocurrency cryptocurrency,
  ) async {
    try {
      final model = CryptocurrencyModel.fromEntity(cryptocurrency);
      await localDataSource.addToFavorites(model);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromFavorites(String id) async {
    try {
      await localDataSource.removeFromFavorites(id);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, bool>> isFavorite(String id) async {
    try {
      final isFav = await localDataSource.isFavorite(id);
      return Right(isFav);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
