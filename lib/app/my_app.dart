import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_product/presentation/cart/provider/cart_provider.dart';
import 'package:search_product/presentation/navigation/main_navigation.dart';
import 'package:search_product/presentation/resources/app_colors.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // FirebaseAnalytics analytics = FirebaseAnalytics();
  static final mainNavigation = MainNavigation();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: Builder(
        builder: (BuildContext context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              // scaffoldBackgroundColor: Colors.blue[100],
              appBarTheme: const AppBarTheme(
                backgroundColor: AppColors.mainDarkBlue,
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: AppColors.mainDarkBlue,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey,
              ),
            ),
            initialRoute: mainNavigation.initialRoute,
            routes: mainNavigation.routes,
          );
        },
      ),
    );
  }
}
