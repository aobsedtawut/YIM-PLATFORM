import 'package:yim_test/core/model/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getAllDataProduct();
}
