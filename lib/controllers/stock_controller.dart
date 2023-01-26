import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:valor/models/stock_model.dart';
import 'package:http/http.dart' as http;

class StockController {
  final String appKey = 'PS13e7l2E553EXd7ajQy1Yhpl2FQleSnu9Bk';
  final String appSecret =
      'i7ANXfra+KuDXYwkk4bukJ3a9ULdKyrxXeH7AXChsSYNsiYRYaIxqUEhnqAayXe2r6VAeJeCFQUPj2yrMOY1LmydcXZMnThNKp7YPYvO+SDInOD3FqA6nL5DSPoHGT3iLXuBn4E9tgPuOdNB2Zx8ZJeHPO5xrNm0JIa67PSUs3ha2Ior0zU=';
  final String authority = 'openapi.koreainvestment.com:9443';
  String accessToken = '';

  // Initialize Stock Controller
  Future<void> initialize() async {
    try {
      http.Response response = await http.post(
        Uri.https(authority, '/oauth2/tokenP'),
        body: jsonEncode({
          'grant_type': 'client_credentials',
          'appkey': appKey,
          'appsecret': appSecret,
        }),
      );

      dynamic body = jsonDecode(response.body);

      accessToken = body['access_token'];
      // ignore: empty_catches
    } catch (e) {}
  }

  // Inquire Price
  Future<StockData> price({
    required String symb,
    required String name,
    required IconData icon,
  }) async {
    try {
      http.Response response = await http.get(
        Uri.https(
          authority,
          '/uapi/overseas-price/v1/quotations/price',
          {
            'AUTH': '',
            'EXCD': 'NAS',
            'SYMB': symb,
          },
        ),
        headers: {
          'authorization': 'Bearer $accessToken',
          'appkey': appKey,
          'appsecret': appSecret,
          'tr_id': 'HHDFS00000300',
        },
      );

      dynamic body = jsonDecode(response.body);
      dynamic output = body['output'];

      return StockData(
        symb: symb,
        name: name,
        icon: icon,
        last: double.parse(output['last']),
        diff: double.parse(output['diff']),
        rate: double.parse(output['rate']),
      );
    } catch (e) {
      return StockData(
        symb: '0',
        name: '0',
        icon: Icons.abc,
        last: 0,
        diff: 0,
        rate: 0,
      );
    }
  }
}
