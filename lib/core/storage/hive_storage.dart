import 'package:hive_flutter/hive_flutter.dart';

import '../../models/cryptocurrency.dart';

class HiveStorage {
  static Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(CryptocurrencyAdapter());
  }
}
