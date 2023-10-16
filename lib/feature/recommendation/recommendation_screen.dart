import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yim_test/core/model/product.dart';

class RecommendationScreen extends StatelessWidget {
  final List<Product>? product;

  const RecommendationScreen({
    super.key,
    required this.product,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recommendation Screen',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            context.go('/home');
          },
        ),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: product!.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              _onItemTapped(
                  context, product![index].id.toString(), product![index]);
            },
            child: Card(
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            product![index].imageUrl,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        product![index].name,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '\$${product![index].price.toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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
