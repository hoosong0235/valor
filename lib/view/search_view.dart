import 'package:flutter/material.dart';
import 'package:valor/model/custom_widget_model.dart';

class SearchView extends StatefulWidget {
  SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.all(32),
                child: CircleAvatar(),
              ),
            ],
          ),
          SizedBox(height: 32),
          Column(
            children: [
              Text(
                'Valor',
                style: textTheme.displayLarge?.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 32),
              CustomSearch(hintText: 'Hinted search text'),
            ],
          )
        ],
      ),
    );
  }
}
