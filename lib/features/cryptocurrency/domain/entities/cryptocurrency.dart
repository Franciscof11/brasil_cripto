import 'package:equatable/equatable.dart';

class Cryptocurrency extends Equatable {
  final String id;
  final String symbol;
  final String name;
  final String? image;
  final double? currentPrice;
  final double? priceChangePercentage24h;
  final double? marketCap;
  final int? marketCapRank;
  final double? totalVolume;
  final double? high24h;
  final double? low24h;
  final String? description;
  final double? ath;
  final String? athDate;
  final double? atl;
  final String? atlDate;
  final DateTime lastUpdated;

  const Cryptocurrency({
    required this.id,
    required this.symbol,
    required this.name,
    this.image,
    this.currentPrice,
    this.priceChangePercentage24h,
    this.marketCap,
    this.marketCapRank,
    this.totalVolume,
    this.high24h,
    this.low24h,
    this.description,
    this.ath,
    this.athDate,
    this.atl,
    this.atlDate,
    required this.lastUpdated,
  });

  @override
  List<Object?> get props => [
    id,
    symbol,
    name,
    image,
    currentPrice,
    priceChangePercentage24h,
    marketCap,
    marketCapRank,
    totalVolume,
    high24h,
    low24h,
    description,
    ath,
    athDate,
    atl,
    atlDate,
    lastUpdated,
  ];

  bool get isPriceIncreasing => (priceChangePercentage24h ?? 0) > 0;

  String get formattedPrice {
    if (currentPrice == null) return '--';
    return '\$${currentPrice!.toStringAsFixed(currentPrice! < 1 ? 6 : 2)}';
  }

  String get formattedPriceChange {
    if (priceChangePercentage24h == null) return '--';
    final change = priceChangePercentage24h!;
    final prefix = change > 0 ? '+' : '';
    return '$prefix${change.toStringAsFixed(2)}%';
  }

  String get formattedMarketCap {
    if (marketCap == null) return '--';
    if (marketCap! >= 1e12) {
      return '\$${(marketCap! / 1e12).toStringAsFixed(2)}T';
    } else if (marketCap! >= 1e9) {
      return '\$${(marketCap! / 1e9).toStringAsFixed(2)}B';
    } else if (marketCap! >= 1e6) {
      return '\$${(marketCap! / 1e6).toStringAsFixed(2)}M';
    }
    return '\$${marketCap!.toStringAsFixed(0)}';
  }

  String get formattedVolume {
    if (totalVolume == null) return '--';
    if (totalVolume! >= 1e9) {
      return '\$${(totalVolume! / 1e9).toStringAsFixed(2)}B';
    } else if (totalVolume! >= 1e6) {
      return '\$${(totalVolume! / 1e6).toStringAsFixed(2)}M';
    }
    return '\$${totalVolume!.toStringAsFixed(0)}';
  }
}
