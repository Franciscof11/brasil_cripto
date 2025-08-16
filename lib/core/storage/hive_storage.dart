import 'package:hive_flutter/hive_flutter.dart';

import '../../features/cryptocurrency/data/models/cryptocurrency_model.dart';

class HiveStorage {
  static Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(CryptocurrencyModelAdapter());
  }
}
