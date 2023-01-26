import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:valor/models/stock_model.dart';
import 'package:http/http.dart' as http;

class StockController {
  final String APP_KEY = 'PS13e7l2E553EXd7ajQy1Yhpl2FQleSnu9Bk';
  final String APP_SECRET =
      'i7ANXfra+KuDXYwkk4bukJ3a9ULdKyrxXeH7AXChsSYNsiYRYaIxqUEhnqAayXe2r6VAeJeCFQUPj2yrMOY1LmydcXZMnThNKp7YPYvO+SDInOD3FqA6nL5DSPoHGT3iLXuBn4E9tgPuOdNB2Zx8ZJeHPO5xrNm0JIa67PSUs3ha2Ior0zU=';
  final String AUTHORITY = 'openapi.koreainvestment.com:9443';
  String ACCESS_TOKEN = '';

  // Initialize Stock Controller
  Future<void> initialize() async {
    try {
      http.Response response = await http.post(
        Uri.https(AUTHORITY, '/oauth2/tokenP'),
        body: jsonEncode({
          'grant_type': 'client_credentials',
          'appkey': APP_KEY,
          'appsecret': APP_SECRET,
        }),
      );

      dynamic body = jsonDecode(response.body);

      ACCESS_TOKEN = body['access_token'];
    } catch (e) {
      print(e);
    }
  }

  // Inquire Price
  Future<StockData> price({
    required String SYMB,
    required String NAME,
    required IconData ICON,
  }) async {
    try {
      http.Response response = await http.get(
        Uri.https(
          AUTHORITY,
          '/uapi/overseas-price/v1/quotations/price',
          {
            'AUTH': '',
            'EXCD': 'NAS',
            'SYMB': SYMB,
          },
        ),
        headers: {
          'authorization': 'Bearer $ACCESS_TOKEN',
          'appkey': APP_KEY,
          'appsecret': APP_SECRET,
          'tr_id': 'HHDFS00000300',
        },
      );

      dynamic body = jsonDecode(response.body);
      dynamic output = body['output'];

      return StockData(
        SYMB: SYMB,
        NAME: NAME,
        ICON: ICON,
        last: double.parse(output['last']),
        diff: double.parse(output['diff']),
        rate: double.parse(output['rate']),
      );
    } catch (e) {
      print('[Error] stock_controller price: $e');

      return StockData(
        SYMB: '0',
        NAME: '0',
        ICON: Icons.abc,
        last: 0,
        diff: 0,
        rate: 0,
      );
    }
  }
}
