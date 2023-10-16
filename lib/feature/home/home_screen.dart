import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yim_test/feature/home/bloc/home_bloc.dart';
import 'package:yim_test/feature/home/bloc/home_state.dart';
import 'package:yim_test/feature/product/widget/product_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().fetchBanner();
    context.read<HomeBloc>().fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeBloc>().state;
    final isLoadingMovie = state.isLoading;
    Theme.of(context).textTheme.bodyLarge;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'YIM PLATFORM',
          style: TextStyle(color: Colors.yellowAccent),
        ),
      ),
      body: Visibility(
        visible: !isLoadingMovie!,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return Visibility(
                  visible: !isLoadingMovie,
                  child: SliverToBoxAdapter(
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 200.0,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                      ),
                      items: state.banner!.map((item) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  item.imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
            ProductList(state: state),
          ],
        ),
      ),
    );
  }
}
