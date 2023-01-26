import 'package:flutter/material.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:valor/controllers/chart_controller.dart';
import 'package:valor/controllers/stock_controller.dart';
import 'package:valor/models/constant_model.dart';
import 'package:valor/models/stock_model.dart';
import 'package:valor/views/card_view.dart';
import 'package:valor/views/chart_view.dart';
import 'package:valor/views/stock_view.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:valor/models/card_model.dart';

// ignore: must_be_immutable
class MainView extends StatelessWidget {
  static String route = 'main_view';
  MainView({super.key});

  ChartController chartController = ChartController();
  StockController stockController = StockController();
  StockModel stockModel = StockModel();
  CardModel cardModel = CardModel();

  Future<bool> initialize() async {
    try {
      await chartController.initialize();
      await stockController.initialize();

      for (int i = 0; i < 100; i++) {
        stockModel.add(
          await stockController.price(
            symb: symbList[i],
            name: nameList[i],
            icon: iconMap[symbList[i]] ?? SimpleIcons.flutter,
          ),
        );
      }
      cardModel.initialize(stockModel.getNMostOrLeastRate(n: 10));
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initialize(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!) {
          return ChangeNotifierProvider(
            create: (context) => StockProvider(
              stockData: stockModel.stockDataList[0],
            ),
            child: Scaffold(
              body: Padding(
                padding: largeEdgeInsets,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: mediumEdgeInsets,
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.attach_money,
                                    size: 32,
                                    color: Colors.green,
                                  ),
                                  Text(
                                    'Valor',
                                    style: largeTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: mediumEdgeInsets,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: List.generate(
                                  cardModel.stockDataList.length,
                                  (index) => CardView(
                                    stockData: cardModel.stockDataList[index],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Padding(
                              padding: mediumEdgeInsets,
                              child: ListView(
                                children: List.generate(
                                  stockModel.stockDataList.length,
                                  (index) => StockView(
                                    stockData: stockModel.stockDataList[index],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: ChartView(chartController: chartController),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: LoadingAnimationWidget.twistingDots(
                leftDotColor: Theme.of(context).colorScheme.primary,
                rightDotColor: Theme.of(context).colorScheme.primary,
                size: 32,
              ),
            ),
          );
        }
      },
    );
  }
}
