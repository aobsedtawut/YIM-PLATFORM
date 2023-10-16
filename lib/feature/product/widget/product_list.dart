import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yim_test/core/model/product.dart';
import 'package:yim_test/feature/home/bloc/home_state.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    super.key,
    required this.state,
  });

  final HomeState state;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2.0, horizontal: 12),
                  child: Text(
                    'Recommendation',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2.0, horizontal: 12),
                  child: InkWell(
                    onTap: () {
                      context.go('/listproduct', extra: state.product);
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 8.0),
                      child: Text(
                        'SEE ALL',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              height: MediaQuery.of(context).size.height * 0.35,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.product!.length,
                itemBuilder: (context, index) {
                  final String id = state.product![index].id.toString();
                  return InkWell(
                    onTap: () {
                      _onItemTapped(context, id, state.product![index]);
                    },
                    child: SizedBox(
                      child: Card(
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        elevation: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              child: Image.network(
                                state.product![index].imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Text(
                              state.product![index].name,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              '\$${state.product![index].price.toStringAsFixed(2)}',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium,
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
        ),
      ),
    );
  }
}

void _onItemTapped(BuildContext context, String id, Product product) {
  context.go(
    '/product/$id',
    extra: product,
  );
}
