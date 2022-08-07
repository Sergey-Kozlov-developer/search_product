import 'package:flutter/material.dart';
import 'package:search_product/presentation/cart/view/cart_screen.dart';
import 'package:search_product/presentation/tabs_navigation/tabs_page.dart';


abstract class MainNavigationRouteNames {
  static const main = '/';
  static const first = '/first';
  static const second = '/second';
  static const cart = '/cart';

}

class MainNavigation {
  final initialRoute = MainNavigationRouteNames.main;
  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.main: (context) => const TabsPage(),
    MainNavigationRouteNames.cart: (context) => const CartScreen(),

  };
  
}
