import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:valor/controllers/chart_controller.dart';
import 'package:valor/models/constant_model.dart';
import 'package:valor/models/chart_model.dart';
import 'package:valor/models/stock_model.dart';

// ignore: must_be_immutable
class ChartView extends StatelessWidget {
  late ChartController chartController;
  ChartModel chartModel = ChartModel();

  ChartView({super.key, required this.chartController});

  Future<bool> initialize({required String symb}) async {
    try {
      chartModel.initialize(await chartController.dailyPrice(symb: symb));

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StockProvider>(
      builder: (context, value, child) => FutureBuilder(
        future: initialize(symb: value.stockData.symb),
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
                            value.stockData.icon,
                            size: 64,
                          ),
                          mediumSizedBox,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                value.stockData.symb,
                                style: smallTextStyle,
                              ),
                              Text(
                                value.stockData.name,
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
                              const Text(
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
                              const Text(
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
                      series: <LineSeries<ChartData, DateTime>>[
                        LineSeries<ChartData, DateTime>(
                          color: Colors.green,
                          dataSource: chartModel.chartDataList,
                          xValueMapper: (ChartData datum, index) =>
                              datum.stckBsopDate,
                          yValueMapper: (ChartData datum, index) =>
                              datum.ovrsNmixPrpr,
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
