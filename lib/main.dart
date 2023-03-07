import 'package:flutter/material.dart';
import 'package:valor/view/chart_view.dart';
import 'package:valor/view/search_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: SearchView.route,
      routes: {
        SearchView.route: (context) => SearchView(),
        ChartView.route: (context) => ChartView(),
      },
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
        brightness: Brightness.dark,
      ),
    );
  }
}
