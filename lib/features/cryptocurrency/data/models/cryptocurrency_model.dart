import 'package:hive/hive.dart';

import '../../domain/entities/cryptocurrency.dart';

part 'cryptocurrency_model.g.dart';

@HiveType(typeId: 0)
class CryptocurrencyModel extends Cryptocurrency {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String symbol;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String? image;
  @HiveField(4)
  final double? currentPrice;
  @HiveField(5)
  final double? priceChangePercentage24h;
  @HiveField(6)
  final double? marketCap;
  @HiveField(7)
  final int? marketCapRank;
  @HiveField(8)
  final double? totalVolume;
  @HiveField(9)
  final double? high24h;
  @HiveField(10)
  final double? low24h;
  @HiveField(11)
  final String? description;
  @HiveField(12)
  final double? ath;
  @HiveField(13)
  final String? athDate;
  @HiveField(14)
  final double? atl;
  @HiveField(15)
  final String? atlDate;
  @HiveField(16)
  final DateTime lastUpdated;

  const CryptocurrencyModel({
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
  }) : super(
         id: id,
         symbol: symbol,
         name: name,
         image: image,
         currentPrice: currentPrice,
         priceChangePercentage24h: priceChangePercentage24h,
         marketCap: marketCap,
         marketCapRank: marketCapRank,
         totalVolume: totalVolume,
         high24h: high24h,
         low24h: low24h,
         description: description,
         ath: ath,
         athDate: athDate,
         atl: atl,
         atlDate: atlDate,
         lastUpdated: lastUpdated,
       );

  factory CryptocurrencyModel.fromJson(Map<String, dynamic> json) {
    return CryptocurrencyModel(
      id: json['id'] as String,
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      image: json['image'] as String?,
      currentPrice: (json['current_price'] as num?)?.toDouble(),
      priceChangePercentage24h: (json['price_change_percentage_24h'] as num?)
          ?.toDouble(),
      marketCap: (json['market_cap'] as num?)?.toDouble(),
      marketCapRank: json['market_cap_rank'] as int?,
      totalVolume: (json['total_volume'] as num?)?.toDouble(),
      high24h: (json['high_24h'] as num?)?.toDouble(),
      low24h: (json['low_24h'] as num?)?.toDouble(),
      description: json['description']?['en'] as String?,
      ath: (json['ath'] as num?)?.toDouble(),
      athDate: json['ath_date'] as String?,
      atl: (json['atl'] as num?)?.toDouble(),
      atlDate: json['atl_date'] as String?,
      lastUpdated: json['last_updated'] != null
          ? DateTime.parse(json['last_updated'] as String)
          : DateTime.now(),
    );
  }

  factory CryptocurrencyModel.fromDetailedJson(Map<String, dynamic> json) {
    return CryptocurrencyModel(
      id: json['id'] as String,
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      image: json['image']?['large'] as String?,
      currentPrice: json['market_data']?['current_price']?['usd']?.toDouble(),
      priceChangePercentage24h:
          json['market_data']?['price_change_percentage_24h']?.toDouble(),
      marketCap: json['market_data']?['market_cap']?['usd']?.toDouble(),
      marketCapRank: json['market_cap_rank'] as int?,
      totalVolume: json['market_data']?['total_volume']?['usd']?.toDouble(),
      high24h: json['market_data']?['high_24h']?['usd']?.toDouble(),
      low24h: json['market_data']?['low_24h']?['usd']?.toDouble(),
      description: json['description']?['en'] as String?,
      ath: json['market_data']?['ath']?['usd']?.toDouble(),
      athDate: json['market_data']?['ath_date']?['usd'] as String?,
      atl: json['market_data']?['atl']?['usd']?.toDouble(),
      atlDate: json['market_data']?['atl_date']?['usd'] as String?,
      lastUpdated: json['last_updated'] != null
          ? DateTime.parse(json['last_updated'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'symbol': symbol,
      'name': name,
      'image': image,
      'current_price': currentPrice,
      'price_change_percentage_24h': priceChangePercentage24h,
      'market_cap': marketCap,
      'market_cap_rank': marketCapRank,
      'total_volume': totalVolume,
      'high_24h': high24h,
      'low_24h': low24h,
      'description': description,
      'ath': ath,
      'ath_date': athDate,
      'atl': atl,
      'atl_date': atlDate,
      'last_updated': lastUpdated.toIso8601String(),
    };
  }

  factory CryptocurrencyModel.fromEntity(Cryptocurrency entity) {
    return CryptocurrencyModel(
      id: entity.id,
      symbol: entity.symbol,
      name: entity.name,
      image: entity.image,
      currentPrice: entity.currentPrice,
      priceChangePercentage24h: entity.priceChangePercentage24h,
      marketCap: entity.marketCap,
      marketCapRank: entity.marketCapRank,
      totalVolume: entity.totalVolume,
      high24h: entity.high24h,
      low24h: entity.low24h,
      description: entity.description,
      ath: entity.ath,
      athDate: entity.athDate,
      atl: entity.atl,
      atlDate: entity.atlDate,
      lastUpdated: entity.lastUpdated,
    );
  }
}
