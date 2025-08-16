import 'dart:convert';

import 'package:http/http.dart' as http;

import '../core/constants/api_constants.dart';
import '../models/cryptocurrency.dart';

class CryptocurrencyService {
  final http.Client _client;

  CryptocurrencyService({http.Client? client})
    : _client = client ?? http.Client();

  Future<List<Cryptocurrency>> getTopCryptocurrencies() async {
    try {
      final response = await _client.get(
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
        return jsonList.map((json) => Cryptocurrency.fromJson(json)).toList();
      } else {
        throw Exception(
          'Failed to load cryptocurrencies: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }

  Future<List<Cryptocurrency>> searchCryptocurrencies(String query) async {
    try {
      final response = await _client.get(
        Uri.parse(
          '${ApiConstants.baseUrl}${ApiConstants.search}',
        ).replace(queryParameters: {'query': query}),
        headers: ApiConstants.headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> coins = jsonResponse['coins'] ?? [];

        final List<Cryptocurrency> cryptocurrencies = [];

        for (final coin in coins.take(20)) {
          try {
            final detailedResponse = await _client.get(
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
                  Cryptocurrency.fromJson(detailedJsonList.first),
                );
              }
            }
          } catch (e) {
            continue;
          }
        }

        return cryptocurrencies;
      } else {
        throw Exception(
          'Failed to search cryptocurrencies: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }

  Future<Cryptocurrency> getCryptocurrencyDetails(String id) async {
    try {
      final response = await _client.get(
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
        return Cryptocurrency.fromDetailedJson(jsonResponse);
      } else {
        throw Exception(
          'Failed to load cryptocurrency details: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }
}
