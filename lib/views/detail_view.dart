import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:valor/controllers/detail_controller.dart';
import 'package:valor/models/constant_model.dart';
import 'package:valor/models/detail_model.dart';
import 'package:valor/models/stock_model.dart';

class DetailView extends StatelessWidget {
  DetailController detailController = DetailController();
  DetailModel detailModel = DetailModel();

  Future<bool> initialize({required String SYMB}) async {
    try {
      await detailController.initialize();
      detailModel.initialize(await detailController.dailyPrice(SYMB: SYMB));

      return true;
    } catch (e) {
      print('[Error] detail_view initialize $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StockProvider>(
      builder: (context, value, child) => FutureBuilder(
        future: initialize(SYMB: value.stockData.SYMB),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!) {
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
                            value.stockData.ICON,
                            size: 64,
                          ),
                          mediumSizedBox,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                value.stockData.SYMB,
                                style: smallTextStyle,
                              ),
                              Text(
                                value.stockData.NAME,
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
                                '\$${value.stockData.last.toStringAsFixed(2)}',
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
                                '${value.stockData.rate < 0 ? '-' : '+'}\$${value.stockData.diff.toStringAsFixed(2)}(${value.stockData.rate.toStringAsFixed(2)}%)',
                                style: largeTextStyle.copyWith(
                                  color: value.stockData.rate < 0
                                      ? Colors.red
                                      : Colors.green,
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
                          dataSource: detailModel.detailDataList,
                          xValueMapper: (DetailData datum, index) =>
                              datum.stck_bsop_date,
                          yValueMapper: (DetailData datum, index) =>
                              datum.ovrs_nmix_prpr,
                          trendlines: <Trendline>[
                            Trendline(
                              type: TrendlineType.linear,
                              color: Colors.white,
                              width: 0.5,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: LoadingAnimationWidget.twistingDots(
                leftDotColor: Theme.of(context).colorScheme.primary,
                rightDotColor: Theme.of(context).colorScheme.primary,
                size: 32,
              ),
            );
          }
        },
      ),
    );
  }
}
