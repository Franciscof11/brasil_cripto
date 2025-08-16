import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../../features/cryptocurrency/data/datasources/cryptocurrency_local_datasource.dart';
import '../../features/cryptocurrency/data/datasources/cryptocurrency_remote_datasource.dart';
import '../../features/cryptocurrency/data/repositories/cryptocurrency_repository_impl.dart';
import '../../features/cryptocurrency/domain/repositories/cryptocurrency_repository.dart';
import '../../features/cryptocurrency/domain/usecases/get_cryptocurrency_details.dart';
import '../../features/cryptocurrency/domain/usecases/get_top_cryptocurrencies.dart';
import '../../features/cryptocurrency/domain/usecases/manage_favorites.dart';
import '../../features/cryptocurrency/domain/usecases/search_cryptocurrencies.dart';
import '../../features/cryptocurrency/presentation/cubit/cryptocurrency_cubit.dart';
import '../../features/cryptocurrency/presentation/cubit/details_cubit.dart';
import '../../features/cryptocurrency/presentation/cubit/favorites_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
    () => CryptocurrencyCubit(
      getTopCryptocurrencies: sl(),
      searchCryptocurrencies: sl(),
    ),
  );

  sl.registerFactory(
    () => FavoritesCubit(
      getFavorites: sl(),
      addToFavorites: sl(),
      removeFromFavorites: sl(),
      checkIsFavorite: sl(),
    ),
  );

  sl.registerFactory(
    () => DetailsCubit(
      getCryptocurrencyDetails: sl(),
      checkIsFavorite: sl(),
      addToFavorites: sl(),
      removeFromFavorites: sl(),
    ),
  );

  sl.registerLazySingleton(() => GetTopCryptocurrencies(sl()));
  sl.registerLazySingleton(() => SearchCryptocurrencies(sl()));
  sl.registerLazySingleton(() => GetCryptocurrencyDetails(sl()));
  sl.registerLazySingleton(() => GetFavorites(sl()));
  sl.registerLazySingleton(() => AddToFavorites(sl()));
  sl.registerLazySingleton(() => RemoveFromFavorites(sl()));
  sl.registerLazySingleton(() => CheckIsFavorite(sl()));

  sl.registerLazySingleton<CryptocurrencyRepository>(
    () => CryptocurrencyRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<CryptocurrencyRemoteDataSource>(
    () => CryptocurrencyRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<CryptocurrencyLocalDataSource>(
    () => CryptocurrencyLocalDataSourceImpl(),
  );

  sl.registerLazySingleton(() => http.Client());
}
