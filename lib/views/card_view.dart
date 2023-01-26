import 'package:flutter/material.dart';
import 'package:valor/models/constant_model.dart';
import 'package:valor/models/stock_model.dart';

class CardView extends StatelessWidget {
  late StockData stockData;

  CardView({
    super.key,
    required this.stockData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Card(
        child: Padding(
          padding: mediumEdgeInsets,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stockData.rate < 0 ? 'Least Rate' : 'Most Rate',
                style: mediumTextStyle.copyWith(
                  color: stockData.rate < 0 ? Colors.red : Colors.green,
                ),
              ),
              Row(
                children: [
                  Icon(
                    stockData.ICON,
                    size: 32,
                  ),
                  mediumSizedBox,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stockData.SYMB,
                        style: smallTextStyle,
                      ),
                      Text(
                        stockData.NAME,
                        style: mediumTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                '${stockData.rate < 0 ? '-' : '+'}\$${stockData.diff.toStringAsFixed(2)}(${stockData.rate.toStringAsFixed(2)}%)',
                style: mediumTextStyle.copyWith(
                  color: stockData.rate < 0 ? Colors.red : Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
