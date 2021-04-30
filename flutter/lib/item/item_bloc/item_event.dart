part of 'item_bloc.dart';

@immutable
abstract class ItemEvent extends Equatable {
  const ItemEvent();
  @override
  List<Object> get props => [];
}

class ItemRequestEvent extends ItemEvent {
  const ItemRequestEvent();
}
