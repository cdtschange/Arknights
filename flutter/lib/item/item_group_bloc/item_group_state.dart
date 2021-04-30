part of 'item_group_bloc.dart';

@immutable
abstract class ItemGroupState extends Equatable {
  final isPimary;
  const ItemGroupState({this.isPimary = true});
  @override
  List<Object> get props => [isPimary];
}

class ItemGroupInitial extends ItemGroupState {
  const ItemGroupInitial({bool isPimary = true}) : super(isPimary: isPimary);
}

class ItemGroupLoadInProgress extends ItemGroupState {
  const ItemGroupLoadInProgress({bool isPimary = true})
      : super(isPimary: isPimary);
}

class ItemGroupLoadSuccess extends ItemGroupState {
  final List<ItemGroup> groups;

  const ItemGroupLoadSuccess({bool isPimary = true, required this.groups})
      : super(isPimary: isPimary);

  @override
  List<Object> get props => [isPimary, groups];
}

class ItemGroupSwitchSuccess extends ItemGroupState {
  final List<ItemGroup> groups;

  const ItemGroupSwitchSuccess({bool isPimary = true, required this.groups})
      : super(isPimary: isPimary);

  @override
  List<Object> get props => [isPimary, groups];
}

class ItemGroupLoadFailure extends ItemGroupState {
  final String message;
  const ItemGroupLoadFailure({required this.message, bool isPimary = true})
      : super(isPimary: isPimary);

  @override
  List<Object> get props => [isPimary, message];
}

class ItemGroupSwitchFailure extends ItemGroupState {
  final String message;
  const ItemGroupSwitchFailure({required this.message, bool isPimary = true})
      : super(isPimary: isPimary);
  @override
  List<Object> get props => [isPimary, message];
}
