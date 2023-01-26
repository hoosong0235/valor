class ChartData {
  final DateTime stck_bsop_date;
  final double ovrs_nmix_prpr;

  ChartData({
    required this.stck_bsop_date,
    required this.ovrs_nmix_prpr,
  });
}

class ChartModel {
  late List<ChartData> chartDataList;

  void initialize(List<ChartData> chartDataList) =>
      this.chartDataList = chartDataList;
}
