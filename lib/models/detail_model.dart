class DetailData {
  final DateTime stck_bsop_date;
  final double ovrs_nmix_prpr;

  DetailData({
    required this.stck_bsop_date,
    required this.ovrs_nmix_prpr,
  });
}

class DetailModel {
  late List<DetailData> detailDataList;

  void initialize(List<DetailData> detailDataList) =>
      this.detailDataList = detailDataList;
}
