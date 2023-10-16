import 'package:yim_test/core/model/banner.dart';

abstract class BannerRepository {
  Future<List<Banner>> getAllDataBanner();
}
