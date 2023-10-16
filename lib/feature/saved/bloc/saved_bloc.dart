import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yim_test/core/model/cart.dart';
import 'package:yim_test/core/model/product.dart';
import 'package:yim_test/core/model/saved.dart';
import 'package:yim_test/feature/cart/bloc/cart_bloc.dart';
import 'package:yim_test/feature/saved/bloc/saved_state.dart';

class SavedListBloc extends Cubit<SavedState> {
  final CartBloc cartCubit;

  SavedListBloc(this.cartCubit) : super(const SavedState(items: []));

  Future<void> addItemToWishlist(SavedListItem newItem) async {
    final setItems = List<SavedListItem>.from(state.items!);
    final mapIndex =
        setItems.indexWhere((item) => item.product.id == newItem.product.id);

    if (mapIndex != -1) {
      setItems.removeAt(mapIndex);
      emit(SavedState(items: [...setItems], isSaved: false));
      return;
    } else {
      setItems.add(SavedListItem(product: newItem.product, quantity: 1));
      emit(SavedState(items: setItems, isSaved: true));
      return;
    }
  }

  void removeFromSavedList(Product product) {
    final updatedItems = List<SavedListItem>.from(state.items!);
    updatedItems.removeWhere((item) => item.product.id == product.id);
    emit(SavedState(items: updatedItems, isSaved: false));
  }

  void removeAll() {
    emit(const SavedState(items: []));
  }
}
