import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yim_test/core/model/cart.dart';
import 'package:yim_test/feature/cart/bloc/cart_bloc.dart';
import 'package:yim_test/feature/saved/bloc/saved_bloc.dart';
import 'package:yim_test/feature/saved/bloc/saved_state.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved', style: Theme.of(context).textTheme.titleLarge),
      ),
      body: BlocBuilder<SavedListBloc, SavedState>(
        builder: (context, state) {
          final savedListItemsWithQuantity = state.items;
          final cartState = context.watch<CartBloc>().state;
          return Column(
            children: [
              if (savedListItemsWithQuantity.isNotEmpty)
                InkWell(
                  onTap: () {
                    context.read<SavedListBloc>().removeAll();
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('Remove All'),
                  ),
                ),
              Expanded(
                child: ListView.builder(
                  itemCount: savedListItemsWithQuantity.length,
                  itemBuilder: (context, index) {
                    final savedListItem = savedListItemsWithQuantity![index];
                    final cartItem = cartState.items.firstWhere(
                      (item) => item.product.id == savedListItem.product.id,
                      orElse: () =>
                          CartItem(product: savedListItem.product, quantity: 0),
                    );

                    return Dismissible(
                      key: Key(savedListItem.product.id.toString()),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 16.0),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      onDismissed: (direction) {
                        context
                            .read<SavedListBloc>()
                            .removeFromSavedList(savedListItem.product);
                      },
                      child: Card(
                        elevation: 8,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 6.0),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          leading:
                              Image.network(savedListItem.product.imageUrl),
                          title: Text(savedListItem.product.name),
                          subtitle: Text(
                              '\$${savedListItem.product.price.toStringAsFixed(2)}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 8.0),
                                child: Text(
                                  cartItem.quantity.toString(),
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
