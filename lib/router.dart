import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yim_test/core/model/cart.dart';
import 'package:yim_test/core/model/product.dart';
import 'package:yim_test/feature/app_shell.dart';
import 'package:yim_test/feature/checkout/check_out_screen.dart';
import 'package:yim_test/feature/home/home_screen.dart';
import 'package:yim_test/feature/product/product_detail_screen.dart';
import 'package:yim_test/feature/cart/cart_screen.dart';
import 'package:yim_test/feature/recommendation/recommendation_screen.dart';
import 'package:yim_test/feature/saved/saved_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/checkout/:totalprice',
      pageBuilder: (BuildContext context, state) {
        final String? totalPrice = state.pathParameters['totalprice'];
        final cartItem = state.extra as List<CartItem>;

        return MaterialPage<void>(
          key: const ValueKey("Check Out"),
          fullscreenDialog: true,
          name: "Check Out",
          child: _checkOutScreen(totalPrice!, cartItem),
        );
      },
    ),
    GoRoute(
      path: '/product/:id',
      pageBuilder: (BuildContext context, state) {
        final String? id = state.pathParameters['id'];
        final product = state.extra as Product;

        return MaterialPage<void>(
          key: const ValueKey("Product Detail"),
          fullscreenDialog: true,
          name: "Product Detail",
          child: _productDetailScreen(
            context,
            id!,
            product,
          ),
        );
      },
    ),
    GoRoute(
      path: '/listproduct',
      pageBuilder: (context, state) {
        final product = state.extra as List<Product>;
        return MaterialPage(
          fullscreenDialog: true,
          arguments: product,
          child: _recommendatonScreen(product),
        );
      },
    ),
    //This is in stack bottom
    StatefulShellRoute.indexedStack(
      builder: (context, state, navShell) {
        return AppShell(navShell: navShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
              routes: <RouteBase>[],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/saved',
              builder: (context, state) {
                return _savedScreen();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/cart',
              builder: (context, state) {
                return _cartScreen();
              },
            ),
          ],
        ),
      ],
    ),
  ],
);

Widget _productDetailScreen(BuildContext context, id, Product product) {
  return ProductDetailScreen(
    id: id,
    product: product,
  );
}

Widget _checkOutScreen(String totalPrice, List<CartItem> cartItem) {
  return CheckOutPage(totalPrice: totalPrice.toString(), cartItem: cartItem);
}

Widget _cartScreen() {
  return const CartScreen();
}

Widget _savedScreen() {
  return SavedScreen();
}

Widget _recommendatonScreen(List<Product> product) {
  return RecommendationScreen(
    product: product,
  );
}
