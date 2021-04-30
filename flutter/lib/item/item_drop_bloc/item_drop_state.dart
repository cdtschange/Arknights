part of 'item_drop_bloc.dart';

@immutable
abstract class ItemDropState extends Equatable {
  const ItemDropState();
  @override
  List<Object> get props => [];
}

class ItemDropInitial extends ItemDropState {}

class ItemDropLoadInProgress extends ItemDropState {}

class ItemDropLoadSuccess extends ItemDropState {
  final List<ItemDrop> itemDrops;

  const ItemDropLoadSuccess({required this.itemDrops}) : super();

  @override
  List<Object> get props => [itemDrops];
}

class ItemDropLoadFailure extends ItemDropState {
  final String message;
  const ItemDropLoadFailure({required this.message}) : super();

  @override
  List<Object> get props => [message];
}
