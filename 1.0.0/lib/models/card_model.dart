import 'package:valor/models/stock_model.dart';

class CardModel {
  late List<StockData> stockDataList;

  void initialize(List<StockData> stockDataList) =>
      this.stockDataList = stockDataList;
}
