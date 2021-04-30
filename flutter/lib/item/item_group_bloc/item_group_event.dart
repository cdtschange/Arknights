part of 'item_group_bloc.dart';

@immutable
abstract class ItemGroupEvent extends Equatable {
  const ItemGroupEvent();
  @override
  List<Object> get props => [];
}

class ItemGroupRequestEvent extends ItemGroupEvent {
  final bool isPrimary;
  const ItemGroupRequestEvent({required this.isPrimary});
  @override
  List<Object> get props => [isPrimary];
}

class ItemGroupSwitchEvent extends ItemGroupEvent {
  final bool isPrimary;
  const ItemGroupSwitchEvent({required this.isPrimary});
  @override
  List<Object> get props => [isPrimary];
}
