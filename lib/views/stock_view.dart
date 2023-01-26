import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valor/models/stock_model.dart';
import 'package:valor/models/constant_model.dart';

class StockView extends StatelessWidget {
  final StockData stockData;

  const StockView({
    super.key,
    required this.stockData,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    if (stockData.symb == 'error') return Container();
    return Consumer<StockProvider>(
      builder: (context, value, child) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: ElevatedButton(
          onPressed: () {
            value.change(
              stockData: stockData,
            );
          },
          style: ButtonStyle(
            shape: const MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
            ),
            backgroundColor: value.stockData.symb == stockData.symb
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
                          style: stockData.name.length > 20
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
