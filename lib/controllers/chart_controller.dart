import 'dart:convert';
import 'package:valor/models/chart_model.dart';
import 'package:http/http.dart' as http;

class ChartController {
  final String APP_KEY = 'PS13e7l2E553EXd7ajQy1Yhpl2FQleSnu9Bk';
  final String APP_SECRET =
      'i7ANXfra+KuDXYwkk4bukJ3a9ULdKyrxXeH7AXChsSYNsiYRYaIxqUEhnqAayXe2r6VAeJeCFQUPj2yrMOY1LmydcXZMnThNKp7YPYvO+SDInOD3FqA6nL5DSPoHGT3iLXuBn4E9tgPuOdNB2Zx8ZJeHPO5xrNm0JIa67PSUs3ha2Ior0zU=';
  final String AUTHORITY = 'openapi.koreainvestment.com:9443';
  String ACCESS_TOKEN = '';

  // Initialize Chart Controller
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

  // Inquire Daily Price
  Future<List<ChartData>> dailyPrice({required String SYMB}) async {
    List<ChartData> chartDataList = [];

    try {
      http.Response response = await http.get(
        Uri.https(
          AUTHORITY,
          '/uapi/overseas-price/v1/quotations/dailyprice',
          {
            'AUTH': '',
            'EXCD': 'NAS',
            'SYMB': SYMB,
            'GUBN': '0',
            'BYMD': '',
            'MODP': '1',
          },
        ),
        headers: {
          'authorization': 'Bearer $ACCESS_TOKEN',
          'appkey': APP_KEY,
          'appsecret': APP_SECRET,
          'tr_id': 'HHDFS76240000',
        },
      );

      dynamic body = jsonDecode(response.body);
      dynamic outputList = body['output2'];

      for (dynamic output in outputList) {
        chartDataList.add(
          ChartData(
            stck_bsop_date: DateTime.parse(output['xymd']),
            ovrs_nmix_prpr: double.parse(output['clos']),
          ),
        );
      }

      return chartDataList;
    } catch (e) {
      print('[Error] chart_controller price: $e');

      return chartDataList;
    }
  }
}
