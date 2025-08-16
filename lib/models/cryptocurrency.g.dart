// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cryptocurrency.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CryptocurrencyAdapter extends TypeAdapter<Cryptocurrency> {
  @override
  final int typeId = 0;

  @override
  Cryptocurrency read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Cryptocurrency(
      id: fields[0] as String,
      symbol: fields[1] as String,
      name: fields[2] as String,
      image: fields[3] as String?,
      currentPrice: fields[4] as double?,
      priceChangePercentage24h: fields[5] as double?,
      marketCap: fields[6] as double?,
      marketCapRank: fields[7] as int?,
      totalVolume: fields[8] as double?,
      high24h: fields[9] as double?,
      low24h: fields[10] as double?,
      description: fields[11] as String?,
      ath: fields[12] as double?,
      athDate: fields[13] as String?,
      atl: fields[14] as double?,
      atlDate: fields[15] as String?,
      lastUpdated: fields[16] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Cryptocurrency obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.symbol)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.currentPrice)
      ..writeByte(5)
      ..write(obj.priceChangePercentage24h)
      ..writeByte(6)
      ..write(obj.marketCap)
      ..writeByte(7)
      ..write(obj.marketCapRank)
      ..writeByte(8)
      ..write(obj.totalVolume)
      ..writeByte(9)
      ..write(obj.high24h)
      ..writeByte(10)
      ..write(obj.low24h)
      ..writeByte(11)
      ..write(obj.description)
      ..writeByte(12)
      ..write(obj.ath)
      ..writeByte(13)
      ..write(obj.athDate)
      ..writeByte(14)
      ..write(obj.atl)
      ..writeByte(15)
      ..write(obj.atlDate)
      ..writeByte(16)
      ..write(obj.lastUpdated);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CryptocurrencyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
