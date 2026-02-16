import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/product.dart';

class ProductRepository {
  Future<List<Product>> loadProducts() async {
    final raw = await rootBundle.loadString('assets/data/products.json');
    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((e) => Product.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
