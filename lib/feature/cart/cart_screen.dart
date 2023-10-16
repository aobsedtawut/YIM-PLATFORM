import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yim_test/feature/cart/bloc/cart_bloc.dart';
import 'package:yim_test/feature/cart/bloc/cart_state.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart Screen',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, cartState) {
            final cartItems = cartState.items;

            double totalPrice = 0;
            for (var cartItem in cartItems) {
              totalPrice += cartItem.product.price * cartItem.quantity;
            }
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final cartItem = cartItems[index];
                          return Dismissible(
                            key: Key(cartItem.product.id.toString()),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(right: 16.0),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            onDismissed: (direction) {
                              context
                                  .read<CartBloc>()
                                  .removeFromCart(cartItem.product);
                            },
                            child: Card(
                              elevation: 8,
                              margin: new EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 6.0),
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                leading: Container(
                                  padding: EdgeInsets.only(right: 12.0),
                                  decoration: new BoxDecoration(
                                    border: new Border(
                                      right: new BorderSide(
                                          width: 1.0, color: Colors.white24),
                                    ),
                                  ),
                                  child: ClipRRect(
                                    child: Image.network(
                                      cartItem.product.imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                title: Text(cartItem.product.name),
                                subtitle: Text(
                                    '\$${cartItem.product.price.toStringAsFixed(2)}'),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove),
                                      onPressed: () {
                                        context.read<CartBloc>().adjustQuantity(
                                            cartItem.product, -1);
                                      },
                                    ),
                                    Text('${cartItem.quantity}'),
                                    IconButton(
                                      icon: Icon(Icons.add),
                                      onPressed: () {
                                        context.read<CartBloc>().adjustQuantity(
                                            cartItem.product, 1);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      color: Colors.orange[300],
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Price:',
                          ),
                          Text(
                            '\$${totalPrice.toStringAsFixed(2)}',
                          ),
                          ElevatedButton(
                            onPressed: () {
                              context.go(
                                '/checkout/$totalPrice',
                                extra: cartItems,
                              );
                            },
                            child: const Text('Check Out'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
