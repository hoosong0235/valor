import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ChartModel {
  final BuildContext context;

  ChartModel({required this.context});

  LineChartData lineChartData() {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    List<Color> colors = [
      colorScheme.tertiary,
      colorScheme.primary,
    ];

    return LineChartData(
      // Chart Theme
      borderData: FlBorderData(
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      gridData: FlGridData(
        getDrawingHorizontalLine: (value) => FlLine(
          color: colorScheme.outlineVariant,
        ),
        getDrawingVerticalLine: (value) => FlLine(
          color: colorScheme.outlineVariant,
        ),
      ),
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: colorScheme.surfaceVariant,
          tooltipBorder: BorderSide(color: colorScheme.surfaceVariant),
          getTooltipItems: (touchedSpots) => List.generate(
            touchedSpots.length,
            (index) => LineTooltipItem(
              touchedSpots[index].y.toStringAsFixed(2),
              textTheme.labelLarge!.copyWith(color: colorScheme.onSurface),
            ),
          ),
        ),
        getTouchedSpotIndicator: (barData, spotIndexes) => List.generate(
          spotIndexes.length,
          (index) => TouchedSpotIndicatorData(
            FlLine(color: Colors.transparent),
            FlDotData(),
          ),
        ),
      ),
      titlesData: FlTitlesData(
        rightTitles: AxisTitles(),
        topTitles: AxisTitles(),
      ),

      // Chart Data
      lineBarsData: [
        LineChartBarData(
          color: colorScheme.primary,
          isCurved: true,
          gradient: LinearGradient(
            colors: colors,
          ),
          dotData: FlDotData(
            show: false,
          ),
          spots: List.generate(
            24,
            (index) => FlSpot(
              index + 1,
              200 *
                  pow(index + 1, 0.5) *
                  (1 + 0.1 * (sin((1 / 6) * pi * index))),
            ),
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: colors.map((e) => e.withAlpha(24)).toList(),
            ),
          ),
        ),
      ],
      maxX: 24,
      maxY: 1000,
    );
  }
}
