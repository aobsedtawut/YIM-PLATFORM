import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:yim_test/core/model/banner.dart';
import 'package:yim_test/core/model/product.dart';
import 'package:yim_test/core/repository/banner_repository.dart';

class BannerRepositoryImpl extends BannerRepository {
  @override
  Future<List<Banner>> getAllDataBanner() async {
    try {
      final String jsonText =
          await rootBundle.loadString('assets/data/banner_mock.json');
      final jsonData = json.decode(jsonText)['banner_items'] as List<dynamic>;
      final result = jsonData.map((data) => Banner.fromJson(data)).toList();
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
