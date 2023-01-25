class StockData {
  final String SYMB;
  final double last;
  final double diff;
  final double fltt_rt;

  StockData({
    required this.SYMB,
    required this.last,
    required this.diff,
    required this.fltt_rt,
  });
}

class StockModel {
  List<StockData> stockDataList = [];

  void add(StockData stockData) => stockDataList.add(stockData);
}
