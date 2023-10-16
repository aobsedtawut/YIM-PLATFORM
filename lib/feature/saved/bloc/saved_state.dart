import 'package:equatable/equatable.dart';
import 'package:yim_test/core/model/saved.dart';

class SavedState extends Equatable {
  final List<SavedListItem> items;
  final bool? isSaved;

  const SavedState({required this.items, this.isSaved = false});

  @override
  List<Object?> get props => [items, isSaved];
}
