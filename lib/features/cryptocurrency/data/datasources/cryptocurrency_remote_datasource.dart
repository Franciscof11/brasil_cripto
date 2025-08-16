import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/cryptocurrency_model.dart';

abstract class CryptocurrencyRemoteDataSource {
  Future<List<CryptocurrencyModel>> getTopCryptocurrencies();
  Future<List<CryptocurrencyModel>> searchCryptocurrencies(String query);
  Future<CryptocurrencyModel> getCryptocurrencyDetails(String id);
}

class CryptocurrencyRemoteDataSourceImpl
    implements CryptocurrencyRemoteDataSource {
  final http.Client client;

  CryptocurrencyRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CryptocurrencyModel>> getTopCryptocurrencies() async {
    try {
      final response = await client.get(
        Uri.parse(
          '${ApiConstants.baseUrl}${ApiConstants.coinsMarkets}',
        ).replace(
          queryParameters: {
            'vs_currency': ApiConstants.defaultCurrency,
            'order': ApiConstants.defaultOrder,
            'per_page': ApiConstants.defaultPerPage.toString(),
            'page': '1',
            'sparkline': ApiConstants.defaultSparkline.toString(),
            'price_change_percentage':
                ApiConstants.defaultPriceChangePercentage,
          },
        ),
        headers: ApiConstants.headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList
            .map((json) => CryptocurrencyModel.fromJson(json))
            .toList();
      } else {
        throw ServerException(
          'Failed to load cryptocurrencies: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw NetworkException('Network error: ${e.toString()}');
    }
  }

  @override
  Future<List<CryptocurrencyModel>> searchCryptocurrencies(String query) async {
    try {
      final response = await client.get(
        Uri.parse(
          '${ApiConstants.baseUrl}${ApiConstants.search}',
        ).replace(queryParameters: {'query': query}),
        headers: ApiConstants.headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> coins = jsonResponse['coins'] ?? [];

        final List<CryptocurrencyModel> cryptocurrencies = [];

        for (final coin in coins.take(20)) {
          try {
            final detailedResponse = await client.get(
              Uri.parse(
                '${ApiConstants.baseUrl}${ApiConstants.coinsMarkets}',
              ).replace(
                queryParameters: {
                  'vs_currency': ApiConstants.defaultCurrency,
                  'ids': coin['id'],
                  'order': ApiConstants.defaultOrder,
                  'per_page': '1',
                  'page': '1',
                  'sparkline': ApiConstants.defaultSparkline.toString(),
                  'price_change_percentage':
                      ApiConstants.defaultPriceChangePercentage,
                },
              ),
              headers: ApiConstants.headers,
            );

            if (detailedResponse.statusCode == 200) {
              final List<dynamic> detailedJsonList = json.decode(
                detailedResponse.body,
              );
              if (detailedJsonList.isNotEmpty) {
                cryptocurrencies.add(
                  CryptocurrencyModel.fromJson(detailedJsonList.first),
                );
              }
            }
          } catch (e) {
            continue;
          }
        }

        return cryptocurrencies;
      } else {
        throw ServerException(
          'Failed to search cryptocurrencies: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw NetworkException('Network error: ${e.toString()}');
    }
  }

  @override
  Future<CryptocurrencyModel> getCryptocurrencyDetails(String id) async {
    try {
      final response = await client.get(
        Uri.parse(
          '${ApiConstants.baseUrl}${ApiConstants.coinDetails}/$id',
        ).replace(
          queryParameters: {
            'localization': 'false',
            'tickers': 'false',
            'market_data': 'true',
            'community_data': 'false',
            'developer_data': 'false',
            'sparkline': 'false',
          },
        ),
        headers: ApiConstants.headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return CryptocurrencyModel.fromDetailedJson(jsonResponse);
      } else {
        throw ServerException(
          'Failed to load cryptocurrency details: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw NetworkException('Network error: ${e.toString()}');
    }
  }
}
