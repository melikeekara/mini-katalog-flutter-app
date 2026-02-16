import 'package:flutter/material.dart';
import '../models/product.dart';
import '../screens/cart_screen.dart';
import '../screens/home_screen.dart';
import '../screens/product_detail_screen.dart';

class AppRoutes {
  static const home = '/';
  static const detail = '/detail';
  static const cart = '/cart';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case detail:
        final product = settings.arguments as Product;
        return MaterialPageRoute(
          builder: (_) => ProductDetailScreen(product: product),
        );
      case cart:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Sayfa bulunamadı'))),
        );
    }
  }
}
