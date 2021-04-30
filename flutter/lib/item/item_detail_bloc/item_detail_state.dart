part of 'item_detail_bloc.dart';

@immutable
abstract class ItemDetailState extends Equatable {
  const ItemDetailState();
  @override
  List<Object> get props => [];
}

class ItemDetailInitial extends ItemDetailState {
  const ItemDetailInitial();
}

class ItemDetailLoadInProgress extends ItemDetailState {}

class ItemDetailLoadSuccess extends ItemDetailState {
  final List<ItemDetail> itemDetails;

  const ItemDetailLoadSuccess({required this.itemDetails});

  @override
  List<Object> get props => [itemDetails];
}

class ItemDetailLoadFailure extends ItemDetailState {
  final String message;

  const ItemDetailLoadFailure({required this.message});

  @override
  List<Object> get props => [message];
}
