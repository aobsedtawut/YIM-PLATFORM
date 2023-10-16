import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yim_test/core/repository/banner_repository.dart';
import 'package:yim_test/core/repository/product_repository.dart';
import 'package:yim_test/feature/home/bloc/home_state.dart';

class HomeBloc extends Cubit<HomeState> {
  final ProductRepository productRepository;
  final BannerRepository bannerRepository;
  HomeBloc({
    required this.productRepository,
    required this.bannerRepository,
  }) : super(const HomeState(product: [], banner: [], favariteProduct: []));

  Future<void> fetchProduct() async {
    emit(state.copyWith(isLoading: true));
    try {
      final resultProduct = await productRepository.getAllDataProduct();
      emit(state.copyWith(product: resultProduct));
    } catch (e) {
      rethrow;
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> fetchBanner() async {
    emit(state.copyWith(isLoading: true));
    try {
      final resultBanner = await bannerRepository.getAllDataBanner();
      emit(state.copyWith(banner: resultBanner));
    } catch (e) {
      rethrow;
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> toggleFavorite(String productId) async {
    final updatedProducts = state.product?.map((product) {
      if (product.id.toString() == productId) {
        product = product.copyWith(isFavorite: !product.isFavorite);
      }
      return product;
    }).toList();

    final updatedFavoriteProducts =
        updatedProducts?.where((product) => product.isFavorite).toList();

    final isProductFavorite = updatedProducts
        ?.firstWhere((product) => product.id.toString() == productId)
        ?.isFavorite;
    await Future.delayed(const Duration(seconds: 1));
    emit(state.copyWith(
      product: updatedProducts,
      favariteProduct: updatedFavoriteProducts,
      isFavorite: isProductFavorite,
    ));
  }
}
