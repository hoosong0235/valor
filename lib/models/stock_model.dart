import 'package:flutter/material.dart';

class StockData {
  final String SYMB;
  final String NAME;
  final IconData ICON;
  final double last;
  final double diff;
  final double rate;

  StockData({
    required this.SYMB,
    required this.NAME,
    required this.ICON,
    required this.last,
    required this.diff,
    required this.rate,
  });
}

class StockModel {
  List<StockData> stockDataList = [];

  void add(StockData stockData) => stockDataList.add(stockData);

  List<StockData> getNMostOrLeastRate({required int n}) {
    List<StockData> sortedStockDataList = stockDataList.map((e) => e).toList();
    sortedStockDataList.sort((a, b) => b.rate.abs().compareTo(a.rate.abs()));

    return sortedStockDataList.sublist(0, n);
  }
}

class StockProvider extends ChangeNotifier {
  late StockData stockData;

  StockProvider({
    required this.stockData,
  });

  void change({
    required StockData stockData,
  }) {
    this.stockData = stockData;
    notifyListeners();
  }
}
