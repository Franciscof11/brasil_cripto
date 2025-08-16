import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injection_container.dart' as di;
import 'core/storage/hive_storage.dart';
import 'features/cryptocurrency/presentation/cubit/cryptocurrency_cubit.dart';
import 'features/cryptocurrency/presentation/cubit/details_cubit.dart';
import 'features/cryptocurrency/presentation/cubit/favorites_cubit.dart';
import 'features/cryptocurrency/presentation/pages/cryptocurrency_details_page.dart';
import 'features/cryptocurrency/presentation/pages/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveStorage.init();

  await di.init();

  runApp(const BrasilCriptoApp());
}

class BrasilCriptoApp extends StatelessWidget {
  const BrasilCriptoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<CryptocurrencyCubit>()),
        BlocProvider(create: (_) => di.sl<FavoritesCubit>()),
        BlocProvider(create: (_) => di.sl<DetailsCubit>()),
      ],
      child: MaterialApp(
        title: 'BrasilCripto',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: const Color(0xFF1976D2),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Roboto',
          appBarTheme: const AppBarTheme(elevation: 0, centerTitle: true),
          cardTheme: CardThemeData(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        home: const MainPage(),
        routes: {
          '/details': (context) {
            final cryptoId =
                ModalRoute.of(context)!.settings.arguments as String;
            return CryptocurrencyDetailsPage(cryptoId: cryptoId);
          },
        },
      ),
    );
  }
}
