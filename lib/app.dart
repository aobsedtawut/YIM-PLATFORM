import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yim_test/common/theme.dart';
import 'package:yim_test/core/repository/banner_repository.dart';
import 'package:yim_test/core/repository/product_repository.dart';
import 'package:yim_test/core/repository_impl/banner_repository_impl.dart';
import 'package:yim_test/core/repository_impl/product_repository_impl.dart';
import 'package:yim_test/feature/app_shell.bloc.dart';
import 'package:yim_test/feature/cart/bloc/cart_bloc.dart';
import 'package:yim_test/feature/home/bloc/home_bloc.dart';
import 'package:yim_test/feature/saved/bloc/saved_bloc.dart';
import 'package:yim_test/router.dart';

class YimApp extends StatelessWidget {
  const YimApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        ..._coreProviders,
        ..._featureProviders,
      ],
      child: MaterialApp.router(
        title: 'YIM TEST',
        theme: yimTheme(context),
        routerConfig: appRouter,
      ),
    );
  }
}

final _featureProviders = [
  BlocProvider<AppShellBloc>(
    create: (context) => AppShellBloc(
      productRepository: context.read<ProductRepository>(),
      bannerRepository: context.read<BannerRepository>(),
    )..startGettingData(),
  ),
  BlocProvider<HomeBloc>(
    create: (context) => HomeBloc(
      productRepository: context.read<ProductRepository>(),
      bannerRepository: context.read<BannerRepository>(),
    ),
  ),
  BlocProvider<CartBloc>(
    create: (context) => CartBloc(),
  ),
  BlocProvider<SavedListBloc>(
    create: (context) => SavedListBloc(
      CartBloc(),
    ),
  ),
];

final _coreProviders = [
  ..._repositories,
];

final _repositories = [
  RepositoryProvider<BannerRepository>(
    create: (context) => BannerRepositoryImpl(),
  ),
  RepositoryProvider<ProductRepository>(
    create: (context) => ProductRepositoryImpl(),
  )
];
