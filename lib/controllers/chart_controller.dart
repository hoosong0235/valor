import 'dart:convert';
import 'package:valor/models/chart_model.dart';
import 'package:http/http.dart' as http;

class ChartController {
  final String appKey = 'PS13e7l2E553EXd7ajQy1Yhpl2FQleSnu9Bk';
  final String appSecret =
      'i7ANXfra+KuDXYwkk4bukJ3a9ULdKyrxXeH7AXChsSYNsiYRYaIxqUEhnqAayXe2r6VAeJeCFQUPj2yrMOY1LmydcXZMnThNKp7YPYvO+SDInOD3FqA6nL5DSPoHGT3iLXuBn4E9tgPuOdNB2Zx8ZJeHPO5xrNm0JIa67PSUs3ha2Ior0zU=';
  final String authority = 'openapi.koreainvestment.com:9443';
  String accessToken = '';

  // Initialize Chart Controller
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

  // Inquire Daily Price
  Future<List<ChartData>> dailyPrice({required String symb}) async {
    List<ChartData> chartDataList = [];

    try {
      http.Response response = await http.get(
        Uri.https(
          authority,
          '/uapi/overseas-price/v1/quotations/dailyprice',
          {
            'AUTH': '',
            'EXCD': 'NAS',
            'SYMB': symb,
            'GUBN': '0',
            'BYMD': '',
            'MODP': '1',
          },
        ),
        headers: {
          'authorization': 'Bearer $accessToken',
          'appkey': appKey,
          'appsecret': appSecret,
          'tr_id': 'HHDFS76240000',
        },
      );

      dynamic body = jsonDecode(response.body);
      dynamic outputList = body['output2'];

      for (dynamic output in outputList) {
        chartDataList.add(
          ChartData(
            stckBsopDate: DateTime.parse(output['xymd']),
            ovrsNmixPrpr: double.parse(output['clos']),
          ),
        );
      }

      return chartDataList;
    } catch (e) {
      return chartDataList;
    }
  }
}
