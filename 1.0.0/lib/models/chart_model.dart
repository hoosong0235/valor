class ChartData {
  final DateTime stckBsopDate;
  final double ovrsNmixPrpr;

  ChartData({
    required this.stckBsopDate,
    required this.ovrsNmixPrpr,
  });
}

class ChartModel {
  late List<ChartData> chartDataList;

  void initialize(List<ChartData> chartDataList) =>
      this.chartDataList = chartDataList;
}
