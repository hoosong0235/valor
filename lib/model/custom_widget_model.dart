import 'package:flutter/material.dart';
import 'package:valor/view/chart_view.dart';
import 'package:valor/view/search_view.dart';

class CustomSearch extends StatelessWidget {
  final String hintText;
  final double width;

  const CustomSearch({
    super.key,
    required this.hintText,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: width,
        height: 56,
        child: Material(
          elevation: 3,
          color: colorScheme.surface,
          shadowColor: colorScheme.shadow,
          surfaceTintColor: colorScheme.surfaceTint,
          borderRadius: BorderRadius.circular(28),
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(28),
            highlightColor: Colors.transparent,
            splashFactory: InkRipple.splashFactory,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Icon(Icons.menu),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        cursorColor: colorScheme.primary,
                        style: textTheme.bodyLarge,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          isCollapsed: true,
                          border: InputBorder.none,
                          hintText: hintText,
                          hintStyle: textTheme.bodyLarge?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pushReplacementNamed(
                      context,
                      ChartView.route,
                    ),
                    icon: Icon(Icons.search),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomGuestProfile extends StatelessWidget {
  CustomGuestProfile({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        CircleAvatar(radius: 24),
        SizedBox(height: 56, width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Guest',
              style: textTheme.titleMedium?.copyWith(
                color: colorScheme.onBackground,
              ),
            ),
            Text(
              '@Guest0235',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onBackground,
              ),
            )
          ],
        )
      ],
    );
  }
}

class CustomNavigationRail extends StatelessWidget {
  final int selectedIndex;

  const CustomNavigationRail({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      labelType: NavigationRailLabelType.selected,
      selectedIndex: selectedIndex,
      onDestinationSelected: (value) => Navigator.pushReplacementNamed(
        context,
        SearchView.route,
      ),
      leading: SizedBox(height: 48),
      trailing: SizedBox(height: 48),
      destinations: [
        NavigationRailDestination(
          icon: Icon(Icons.search),
          label: Text('Search'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.circle_outlined),
          selectedIcon: Icon(Icons.circle),
          label: Text('Chart'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.circle_outlined),
          selectedIcon: Icon(Icons.circle),
          label: Text('Navigation'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.circle_outlined),
          selectedIcon: Icon(Icons.circle),
          label: Text('Navigation'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.circle_outlined),
          selectedIcon: Icon(Icons.circle),
          label: Text('Navigation'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.circle_outlined),
          selectedIcon: Icon(Icons.circle),
          label: Text('Navigation'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.circle_outlined),
          selectedIcon: Icon(Icons.circle),
          label: Text('Navigation'),
        ),
      ],
    );
  }
}
