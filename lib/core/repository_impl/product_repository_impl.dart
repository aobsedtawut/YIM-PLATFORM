import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:yim_test/core/model/product.dart';
import 'package:yim_test/core/repository/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  @override
  Future<List<Product>> getAllDataProduct() async {
    try {
      final String jsonText =
          await rootBundle.loadString('assets/data/product_mock.json');
      final jsonData = json.decode(jsonText)['product_items'] as List<dynamic>;
      final result = jsonData.map((data) => Product.fromJson(data)).toList();
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
