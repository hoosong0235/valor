import 'package:flutter/material.dart';
import 'package:valor/models/constant_model.dart';
import 'package:valor/models/stock_model.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CardView extends StatelessWidget {
  late StockData stockData;

  CardView({
    super.key,
    required this.stockData,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Consumer<StockProvider>(
      builder: (context, value, child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: ElevatedButton(
          onPressed: () {
            value.change(
              stockData: stockData,
            );
          },
          style: ButtonStyle(
            backgroundColor: value.stockData.symb == stockData.symb
                ? MaterialStatePropertyAll(colorScheme.surfaceVariant)
                : MaterialStatePropertyAll(colorScheme.surface),
            shape: const MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
            ),
          ),
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
                      color: colorScheme.onBackground,
                    ),
                    mediumSizedBox,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          stockData.symb,
                          style: smallTextStyle.copyWith(
                            color: colorScheme.onBackground,
                          ),
                        ),
                        Text(
                          stockData.name,
                          style: stockData.name.length > 15
                              ? smallTextStyle.copyWith(
                                  color: colorScheme.onBackground,
                                )
                              : mediumTextStyle.copyWith(
                                  color: colorScheme.onBackground,
                                ),
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
      ),
    );
  }
}
