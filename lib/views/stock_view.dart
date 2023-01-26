import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valor/models/stock_model.dart';
import 'package:valor/models/constant_model.dart';

class StockView extends StatelessWidget {
  final String SYMB;
  final String NAME;
  final IconData ICON;
  final StockData stockData;

  StockView({
    super.key,
    required this.NAME,
    required this.SYMB,
    required this.ICON,
    required this.stockData,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Consumer<StockProvider>(
      builder: (context, value, child) => Padding(
        padding: EdgeInsets.symmetric(vertical: 6),
        child: ElevatedButton(
          onPressed: () {
            value.change(
              stockData: stockData,
            );
          },
          style: ButtonStyle(
            backgroundColor: value.stockData.SYMB == SYMB
                ? MaterialStatePropertyAll(colorScheme.surfaceVariant)
                : MaterialStatePropertyAll(colorScheme.surface),
          ),
          child: Padding(
            padding: mediumEdgeInsets,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(
                      ICON,
                      size: 32,
                      color: colorScheme.onBackground,
                    ),
                    mediumSizedBox,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          stockData.SYMB,
                          style: smallTextStyle.copyWith(
                            color: colorScheme.onBackground,
                          ),
                        ),
                        Text(
                          NAME,
                          style: mediumTextStyle.copyWith(
                            color: colorScheme.onBackground,
                          ),
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
                          style: smallTextStyle.copyWith(
                            color: colorScheme.onBackground,
                          ),
                        ),
                        Text(
                          '\$${stockData.last.toStringAsFixed(2)}',
                          style: mediumTextStyle.copyWith(
                            color: colorScheme.onBackground,
                          ),
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
                          style: smallTextStyle.copyWith(
                            color: colorScheme.onBackground,
                          ),
                        ),
                        Text(
                          '${stockData.rate < 0 ? '-' : '+'}\$${stockData.diff.toStringAsFixed(2)}(${stockData.rate.toStringAsFixed(2)}%)',
                          style: mediumTextStyle.copyWith(
                            color:
                                stockData.rate < 0 ? Colors.red : Colors.green,
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
      ),
    );
  }
}
