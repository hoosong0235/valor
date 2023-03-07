import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:valor/model/chart_model.dart';
import 'package:valor/model/custom_widget_model.dart';

class ChartView extends StatefulWidget {
  static String route = 'chart_view';

  ChartView({super.key});

  @override
  State<ChartView> createState() => _ChartViewState();
}

class _ChartViewState extends State<ChartView> {
  @override
  Widget build(BuildContext context) {
    ChartModel chartModel = ChartModel(context: context);
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Row(
        children: [
          CustomNavigationRail(selectedIndex: 1),
          SizedBox(width: 24),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 48),
                CustomSearch(
                  hintText: 'Hinted search text',
                  width: double.infinity,
                ),
                SizedBox(height: 24),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(36),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(SimpleIcons.apple, size: 48),
                                  SizedBox(width: 24),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Apple',
                                        style: textTheme.titleLarge?.copyWith(
                                          color: colorScheme.onSurface,
                                        ),
                                      ),
                                      Text(
                                        'APPL',
                                        style: textTheme.bodyLarge?.copyWith(
                                          color: colorScheme.onSurface,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  OutlinedButton.icon(
                                    onPressed: () {},
                                    icon: Icon(Icons.arrow_upward),
                                    label: Text('+3.05%'),
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    '\$2,002',
                                    style: textTheme.headlineLarge?.copyWith(
                                      color: colorScheme.onSurface,
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.star_outline),
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 24),
                          Divider(),
                          SizedBox(height: 24),
                          Row(
                            children: List.generate(
                              6,
                              (index) => Row(
                                children: [
                                  SizedBox(width: 24),
                                  FilterChip(
                                    selected: index == 0,
                                    label: Text('Enabled'),
                                    onSelected: (value) {},
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
                          Expanded(
                            child: LineChart(chartModel.lineChartData()),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 48),
              ],
            ),
          ),
          SizedBox(width: 24),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 48),
                CustomGuestProfile(),
                SizedBox(height: 24),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        children: [
                          AppBar(
                            backgroundColor: Colors.transparent,
                            surfaceTintColor: Colors.transparent,
                            leading: Icon(Icons.access_time),
                            title: Text('Title'),
                          ),
                          Expanded(
                            child: ListView(
                              children: List.generate(
                                24,
                                (index) => Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 12,
                                          horizontal: 24,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '521',
                                              style: textTheme.labelSmall
                                                  ?.copyWith(
                                                color: colorScheme
                                                    .onSurfaceVariant,
                                              ),
                                            ),
                                            Text(
                                              '2,001',
                                              style:
                                                  textTheme.bodyLarge?.copyWith(
                                                color: colorScheme.primary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 12,
                                          horizontal: 24,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '2,002',
                                              style:
                                                  textTheme.bodyLarge?.copyWith(
                                                color: colorScheme.error,
                                              ),
                                            ),
                                            Text(
                                              '2,019',
                                              style: textTheme.labelSmall
                                                  ?.copyWith(
                                                color: colorScheme
                                                    .onSurfaceVariant,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 48),
              ],
            ),
          ),
          SizedBox(width: 24),
        ],
      ),
    );
  }
}
