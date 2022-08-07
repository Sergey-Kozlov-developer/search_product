import 'package:flutter/material.dart';
import 'package:search_product/presentation/cart/view/cart_screen.dart';
import 'package:search_product/presentation/cart/view/product_list.dart';
import 'package:search_product/presentation/not_info/not_info.dart';

class TabNavigationItem {
  final Widget page;

  // final Widget title;
  final String label;
  final Icon icon;

  TabNavigationItem({
    required this.page,
    required this.label,
    required this.icon,
  });

  static List<TabNavigationItem> get items => [
        TabNavigationItem(
          page: const ProductList(),
          icon: const Icon(Icons.search),
          label: 'Поиск',

        ),
        TabNavigationItem(
          page: NotInfo(),
          icon: const Icon(Icons.close),
          label: 'Заглушка',
        ),
        TabNavigationItem(
          page: const NotInfo(),
          icon: const Icon(Icons.close),
          label: 'Заглушка',
          // label: const Text('Поиск'),
        ),
      ];
}
