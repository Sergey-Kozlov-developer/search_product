import 'package:flutter/material.dart';
import 'package:search_product/presentation/resources/app_colors.dart';
// import 'package:misbox/ui/resources/app_colors.dart';

import 'tabs_navigation_item.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          for (final tabItem in TabNavigationItem.items) tabItem.page,
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) => setState(() => _currentIndex = index),
        items: [
          for (final tabItem in TabNavigationItem.items)
            BottomNavigationBarItem(
              backgroundColor: AppColors.mainDarkBlue,
              icon: tabItem.icon,
              label: tabItem.label,

            )
        ],
      ),
    );
  }
}
