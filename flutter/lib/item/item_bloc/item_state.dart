part of 'item_bloc.dart';

@immutable
abstract class ItemState extends Equatable {
  const ItemState();
  @override
  List<Object> get props => [];
}

class ItemInitial extends ItemState {}

class ItemLoadInProgress extends ItemState {}

class ItemLoadSuccess extends ItemState {
  final List<Item> items;

  const ItemLoadSuccess({required this.items});

  @override
  List<Object> get props => [items];
}

class ItemLoadFailure extends ItemState {
  final String message;

  const ItemLoadFailure({required this.message});

  @override
  List<Object> get props => [message];
}
