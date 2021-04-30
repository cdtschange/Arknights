part of 'item_detail_bloc.dart';

@immutable
abstract class ItemDetailEvent extends Equatable {
  const ItemDetailEvent();
  @override
  List<Object> get props => [];
}

class ItemDetailRequestEvent extends ItemDetailEvent {
  const ItemDetailRequestEvent();
}
