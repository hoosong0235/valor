import 'package:flutter/material.dart';
import 'package:valor/models/constant_model.dart';
import 'package:valor/models/stock_model.dart';

// ignore: must_be_immutable
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
                    stockData.icon,
                    size: 32,
                  ),
                  mediumSizedBox,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stockData.symb,
                        style: smallTextStyle,
                      ),
                      Text(
                        stockData.name,
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
