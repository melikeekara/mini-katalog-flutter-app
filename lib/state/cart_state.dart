import 'package:flutter/material.dart';
import '../models/product.dart';

class CartState extends ChangeNotifier {
  final List<Product> _items = [];

  List<Product> get items => List.unmodifiable(_items);
  int get count => _items.length;

  double get total => _items.fold(0.0, (sum, p) => sum + p.price);

  bool contains(Product p) => _items.any((x) => x.id == p.id);

  void add(Product p) {
    _items.add(p);
    notifyListeners();
  }

  void remove(Product p) {
    _items.removeWhere((x) => x.id == p.id);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}

/// Paketsiz state yönetimi: InheritedNotifier
class CartScope extends InheritedNotifier<CartState> {
  const CartScope({super.key, required super.notifier, required super.child});

  static CartState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<CartScope>();
    if (scope == null || scope.notifier == null) {
      throw Exception(
        'CartScope bulunamadı. main.dart içinde CartScope var mı?',
      );
    }
    return scope.notifier!;
  }
}
