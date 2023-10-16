import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yim_test/core/model/cart.dart';
import 'package:yim_test/core/model/product.dart';
import 'package:yim_test/feature/cart/bloc/cart_state.dart';

class CartBloc extends Cubit<CartState> {
  CartBloc() : super(const CartState(items: []));

  Future<void> addToCart(
    Product product,
  ) async {
    final setItems = List<CartItem>.from(state.items);
    final mapIndex =
        setItems.indexWhere((item) => item.product.id == product.id);

    if (mapIndex != -1) {
      setItems[mapIndex] =
          CartItem(product: product, quantity: setItems[mapIndex].quantity + 1);
    } else {
      setItems.add(CartItem(product: product, quantity: 1));
    }
    emit(CartState(items: setItems));
    return;
  }

  void removeFromCart(Product product) {
    final updatedItems = List<CartItem>.from(state.items);
    updatedItems.removeWhere((item) => item.product.id == product.id);
    emit(CartState(items: updatedItems));
  }

  Future<void> adjustQuantity(Product product, int quantityChange) async {
    final updatedItems = List<CartItem>.from(state.items);
    final existingIndex =
        updatedItems.indexWhere((item) => item.product.id == product.id);

    if (existingIndex != -1) {
      final newQuantity = updatedItems[existingIndex].quantity + quantityChange;
      if (newQuantity > 0) {
        updatedItems[existingIndex] =
            CartItem(product: product, quantity: newQuantity);
      } else {
        updatedItems.removeAt(existingIndex);
      }
      emit(CartState(items: updatedItems));
    }
  }
}
