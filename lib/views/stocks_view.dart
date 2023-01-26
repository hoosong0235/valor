import 'package:flutter/material.dart';
import 'package:valor/controllers/stock_controller.dart';
import 'package:valor/models/constant_model.dart';
import 'package:valor/models/stock_model.dart';
import 'package:valor/views/card_view.dart';
import 'package:valor/views/detail_view.dart';
import 'package:valor/views/stock_view.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class StocksView extends StatelessWidget {
  static String route = 'stocks_view';
  StocksView({super.key});

  StockController stockController = StockController();
  StockModel stockModel = StockModel();

  Future<bool> initialize() async {
    try {
      await stockController.initialize();
      for (int i = 0; i < SYMBList.length; i++) {
        stockModel.add(
          await stockController.price(
            SYMB: SYMBList[i],
            NAME: NAMEList[i],
            ICON: ICONList[i],
          ),
        );
      }
      return true;
    } catch (e) {
      print('[Error] stocks_view initialize $e');
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
                                children: [
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
                                children: [
                                  CardView(
                                    stockData: stockModel.nth(
                                        n: stockModel.stockDataList.length - 1),
                                  ),
                                  CardView(
                                    stockData: stockModel.nth(
                                        n: stockModel.stockDataList.length - 2),
                                  ),
                                  CardView(
                                    stockData: stockModel.nth(n: 1),
                                  ),
                                  CardView(
                                    stockData: stockModel.nth(n: 0),
                                  ),
                                ],
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
                                    NAME: NAMEList[index],
                                    SYMB: SYMBList[index],
                                    ICON: ICONList[index],
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
                      child: DetailView(),
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
