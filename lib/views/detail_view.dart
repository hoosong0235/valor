import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:valor/models/constant_model.dart';
import 'package:valor/models/detail_model.dart';

class DetailView extends StatelessWidget {
  DetailView({super.key});

  DetailModel stockModel = DetailModel();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: mediumEdgeInsets,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.apple,
                    size: 64,
                  ),
                  mediumSizedBox,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AAPL',
                        style: smallTextStyle,
                      ),
                      Text(
                        'APPLE',
                        style: largeTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Stock Price',
                        style: smallTextStyle,
                      ),
                      Text(
                        '\$00.00',
                        style: largeTextStyle,
                      ),
                    ],
                  ),
                  largeSizedBox,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Daily Change',
                        style: smallTextStyle,
                      ),
                      Text(
                        '+\$0.00(+0.0%)',
                        style: largeTextStyle.copyWith(
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: mediumEdgeInsets,
            child: SfCartesianChart(
              primaryXAxis: DateTimeAxis(),
              primaryYAxis: NumericAxis(),
              series: <LineSeries<DetailData, DateTime>>[
                LineSeries<DetailData, DateTime>(
                  color: Colors.green,
                  dataSource: stockModel.stockDataList,
                  xValueMapper: (DetailData datum, index) =>
                      datum.stck_bsop_date,
                  yValueMapper: (DetailData datum, index) =>
                      datum.ovrs_nmix_prpr,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
