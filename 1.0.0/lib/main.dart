import 'package:flutter/material.dart';
import 'package:valor/views/main_view.dart';

void main() {
  runApp(const Valor());
}

class Valor extends StatelessWidget {
  const Valor({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
        brightness: Brightness.dark,
      ),
      routes: {
        MainView.route: (context) => MainView(),
      },
      initialRoute: MainView.route,
    );
  }
}
