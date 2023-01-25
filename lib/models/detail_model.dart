class DetailData {
  final DateTime stck_bsop_date;
  final double ovrs_nmix_prpr;

  DetailData({
    required this.stck_bsop_date,
    required this.ovrs_nmix_prpr,
  });
}

class DetailModel {
  List<DetailData> stockDataList = [
    DetailData(
      stck_bsop_date: DateTime(2023, 1, 1),
      ovrs_nmix_prpr: 1,
    ),
    DetailData(
      stck_bsop_date: DateTime(2023, 1, 3),
      ovrs_nmix_prpr: 4,
    ),
    DetailData(
      stck_bsop_date: DateTime(2023, 1, 5),
      ovrs_nmix_prpr: 3,
    ),
    DetailData(
      stck_bsop_date: DateTime(2023, 1, 7),
      ovrs_nmix_prpr: 6,
    ),
    DetailData(
      stck_bsop_date: DateTime(2023, 1, 9),
      ovrs_nmix_prpr: 5,
    ),
    DetailData(
      stck_bsop_date: DateTime(2023, 1, 11),
      ovrs_nmix_prpr: 8,
    ),
  ];
}
