import 'package:flutter/material.dart';
import 'package:valor/controllers/stock_controller.dart';
import 'package:valor/models/stock_model.dart';
import 'package:valor/models/constant_model.dart';

class StockView extends StatefulWidget {
  final String SYMB;
  final String NAME;
  final IconData ICON;
  final StockController stockController;

  StockView({
    super.key,
    required this.NAME,
    required this.SYMB,
    required this.ICON,
    required this.stockController,
  });

  @override
  State<StockView> createState() => _StockViewState();
}

class _StockViewState extends State<StockView> {
  Future<StockData> receiveStockData() async {
    return await widget.stockController.price(SYMB: widget.SYMB);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: mediumEdgeInsets,
        child: FutureBuilder<StockData>(
          future: receiveStockData(),
          initialData: StockData(
            SYMB: 'LOADING',
            last: 0.00,
            diff: 0.00,
            fltt_rt: 0.00,
          ),
          builder: (context, snapshot) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(
                    widget.ICON,
                    size: 32,
                  ),
                  mediumSizedBox,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data!.SYMB,
                        style: smallTextStyle,
                      ),
                      Text(
                        widget.NAME,
                        style: mediumTextStyle,
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
                        '\$${snapshot.data!.last.toStringAsFixed(2)}',
                        style: mediumTextStyle,
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
                        '${snapshot.data!.fltt_rt < 0 ? '-' : '+'}\$${snapshot.data!.diff.toStringAsFixed(2)}(${snapshot.data!.fltt_rt.toStringAsFixed(2)}%)',
                        style: mediumTextStyle.copyWith(
                          color: snapshot.data!.fltt_rt < 0
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
      ),
    );
  }
}
