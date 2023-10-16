import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yim_test/core/repository/banner_repository.dart';
import 'package:yim_test/core/repository/product_repository.dart';
import 'package:yim_test/feature/app_shell_state.dart';

class AppShellBloc extends Cubit<AppShellState> {
  final BannerRepository bannerRepository;
  final ProductRepository productRepository;

  AppShellBloc(
      {required this.bannerRepository, required this.productRepository})
      : super(AppShellState());

  Future<void> startGettingData() async {
    bannerRepository.getAllDataBanner();
    productRepository.getAllDataProduct();
  }
}
