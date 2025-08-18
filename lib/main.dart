import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'models/cryptocurrency.dart';
import 'services/cryptocurrency_service.dart';
import 'services/favorites_service.dart';
import 'viewmodels/cryptocurrency_details_viewmodel.dart';
import 'viewmodels/cryptocurrency_viewmodel.dart';
import 'viewmodels/favorites_viewmodel.dart';
import 'views/pages/cryptocurrency_details_page.dart';
import 'views/pages/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(CryptocurrencyAdapter());

  runApp(const BrasilCriptoApp());
}

class BrasilCriptoApp extends StatelessWidget {
  const BrasilCriptoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider()..init(),
        ),

        Provider<CryptocurrencyService>(create: (_) => CryptocurrencyService()),
        Provider<FavoritesService>(create: (_) => FavoritesService()),

        ChangeNotifierProvider<CryptocurrencyViewModel>(
          create: (context) => CryptocurrencyViewModel(
            cryptocurrencyService: context.read<CryptocurrencyService>(),
          ),
        ),
        ChangeNotifierProvider<FavoritesViewModel>(
          create: (context) => FavoritesViewModel(
            favoritesService: context.read<FavoritesService>(),
          ),
        ),
        ChangeNotifierProvider<CryptocurrencyDetailsViewModel>(
          create: (context) => CryptocurrencyDetailsViewModel(
            cryptocurrencyService: context.read<CryptocurrencyService>(),
            favoritesService: context.read<FavoritesService>(),
          ),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'BrasilCripto',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            home: const MainPage(),
            routes: {
              '/details': (context) {
                final cryptoId =
                    ModalRoute.of(context)!.settings.arguments as String;
                return CryptocurrencyDetailsPage(cryptoId: cryptoId);
              },
            },
          );
        },
      ),
    );
  }
}
