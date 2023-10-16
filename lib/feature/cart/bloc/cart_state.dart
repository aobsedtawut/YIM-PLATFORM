import 'package:equatable/equatable.dart';
import 'package:yim_test/core/model/cart.dart';

class CartState extends Equatable {
  final List<CartItem> items;
  final List<CartItem>? cartItems;

  const CartState({required this.items, this.cartItems});

  @override
  List<Object?> get props => [items, cartItems];
}
