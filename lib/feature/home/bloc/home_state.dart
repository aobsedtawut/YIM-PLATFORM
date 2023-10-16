import 'package:equatable/equatable.dart';
import 'package:yim_test/core/model/banner.dart';
import 'package:yim_test/core/model/product.dart';

class HomeState extends Equatable {
  final List<Product>? product;
  final List<Product>? favariteProduct;
  final List<Banner>? banner;
  final bool? isLoading;
  final bool? isFavorite;

  const HomeState({
    this.product,
    this.isLoading,
    this.banner,
    this.isFavorite,
    this.favariteProduct,
  });
  HomeState copyWith({
    bool? isLoading = false,
    bool? isFavorite = false,
    List<Product>? product,
    List<Banner>? banner,
    List<Product>? favariteProduct,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      product: product ?? this.product,
      isFavorite: isFavorite ?? this.isFavorite,
      favariteProduct: favariteProduct ?? this.favariteProduct,
      banner: banner ?? this.banner,
    );
  }

  @override
  List<Object?> get props => [
        product,
        isLoading,
        isFavorite,
        banner,
        favariteProduct,
      ];
}

class HomeLoadingState extends HomeState {
  const HomeLoadingState({super.product});
}
