import 'package:flutter/material.dart';
import 'package:valor/controllers/stock_controller.dart';
import 'package:valor/models/constant_model.dart';
import 'package:valor/views/card_view.dart';
import 'package:valor/views/detail_view.dart';
import 'package:valor/views/stock_view.dart';

class StocksView extends StatefulWidget {
  static String route = 'stocks_view';
  const StocksView({super.key});

  @override
  State<StocksView> createState() => _StocksViewState();
}

class _StocksViewState extends State<StocksView> {
  StockController stockController = StockController();

  Future<bool> initializeStockController() async {
    try {
      await stockController.initialize();

      return true;
    } catch (e) {
      print('[Error] stocks_view initializeStockController $e');

      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          CardView(),
                          CardView(),
                          CardView(),
                          CardView(),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Padding(
                      padding: mediumEdgeInsets,
                      child: FutureBuilder<void>(
                        future: initializeStockController(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView(
                              children: List.generate(
                                SYMBList.length,
                                (index) => StockView(
                                  SYMB: SYMBList[index],
                                  NAME: NAMEList[index],
                                  ICON: ICONList[index],
                                  stockController: stockController,
                                ),
                              ),
                            );
                          } else {
                            return ListView();
                          }
                        },
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
    );
  }
}
