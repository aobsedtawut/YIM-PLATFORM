import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yim_test/common/snack_helper.dart';
import 'package:yim_test/core/model/product.dart';
import 'package:yim_test/core/model/saved.dart';
import 'package:yim_test/feature/cart/bloc/cart_bloc.dart';
import 'package:yim_test/feature/cart/bloc/cart_state.dart';
import 'package:yim_test/feature/home/bloc/home_bloc.dart';
import 'package:yim_test/feature/home/bloc/home_state.dart';
import 'package:yim_test/feature/saved/bloc/saved_bloc.dart';
import 'package:yim_test/feature/saved/bloc/saved_state.dart';

class ProductDetailScreen extends StatefulWidget {
  final String id;
  final Product product;

  const ProductDetailScreen({
    super.key,
    required this.id,
    required this.product,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final savedState = context.watch<SavedListBloc>().state;
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Product', style: Theme.of(context).textTheme.titleLarge),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              context.go('/home');
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              Image.network(
                widget.product.imageUrl,
                width: double.infinity,
                scale: 1.0,
                fit: BoxFit.cover,
              ),
              InkWell(
                onTap: () {
                  final SavedListItem item =
                      SavedListItem(product: widget.product, quantity: 1);
                  context.read<SavedListBloc>().addItemToWishlist(item);
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: EdgeInsets.all(6),
                    child: CircleAvatar(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      child: BlocConsumer<SavedListBloc, SavedState>(
                        listener: (context, state) {
                          if (state.isSaved == true) {
                            showSnackBar(context, text: 'saved');
                          } else {
                            showSnackBar(
                              context,
                              text: 'Unsaved',
                              type: SnackBarType.error,
                            );
                          }
                        },
                        builder: (context, state) {
                          return SavedIcon(
                            isSaved: savedState.isSaved ?? false,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                widget.product.name,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                '\$${widget.product.price.toStringAsFixed(2)}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  context.read<CartBloc>().addToCart(widget.product);
                  showSnackBar(
                    context,
                    text: 'Add item',
                  );
                },
                child: Text('ADD CART'),
              ),
            ],
          ),
        ),
        bottomNavigationBar: null,
      ),
    );
  }
}

class SavedIcon extends StatelessWidget {
  final bool? isSaved;

  const SavedIcon({super.key, required this.isSaved});

  @override
  Widget build(BuildContext context) {
    return Icon(
      isSaved! ? Icons.favorite : Icons.favorite_border,
      color: Colors.red,
    );
  }
}
