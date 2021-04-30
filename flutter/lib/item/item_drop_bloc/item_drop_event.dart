part of 'item_drop_bloc.dart';

@immutable
abstract class ItemDropEvent extends Equatable {
  const ItemDropEvent();
  @override
  List<Object> get props => [];
}

class ItemDropRequestEvent extends ItemDropEvent {
  const ItemDropRequestEvent();
}
