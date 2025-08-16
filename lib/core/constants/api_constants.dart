class ApiConstants {
  static const String baseUrl = 'https://api.coingecko.com/api/v3';
  static const String coinsMarkets = '/coins/markets';
  static const String coinDetails = '/coins';
  static const String search = '/search';

  static const String defaultCurrency = 'usd';
  static const String defaultOrder = 'market_cap_desc';
  static const int defaultPerPage = 100;
  static const bool defaultSparkline = false;
  static const String defaultPriceChangePercentage = '24h';

  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}
