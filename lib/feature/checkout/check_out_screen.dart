import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:yim_test/core/model/cart.dart';

class CheckOutPage extends StatelessWidget {
  final List<CartItem> cartItem;
  final String totalPrice;

  const CheckOutPage(
      {super.key, required this.totalPrice, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    List<CartItem> cartItems = cartItem;
    final checkoutUrl =
        'https://payment-api.yimplatform.com/checkout?price=$totalPrice';
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Checkout',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.go('/home');
            },
          ),
        ),
        body: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: SizedBox(height: 40),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  QrImageView(
                    data: checkoutUrl,
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                  Text(
                    'Your Cart Items:',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  // Add a divider for separation
                  Divider(height: 20, thickness: 2),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final cartItem = cartItems[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(cartItem.product.name),
                      ),
                      SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            '\$${cartItem.product.price.toStringAsFixed(2)}'),
                      ),
                    ],
                  );
                },
                childCount: cartItems.length,
              ),
            ),
            SliverToBoxAdapter(
              child: Center(
                child: Text(
                  'Total Price: \$${totalPrice}',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ],
        ));
  }
}
