part of 'item_factory_bloc.dart';

@immutable
abstract class ItemFactoryState extends Equatable {
  const ItemFactoryState();
  @override
  List<Object?> get props => [];
}

class ItemFactoryInitial extends ItemFactoryState {}

class ItemFactoryLoadInProgress extends ItemFactoryState {}

class ItemFactoryLoadSuccess extends ItemFactoryState {
  final List<ItemFactory> itemFactories;

  const ItemFactoryLoadSuccess({required this.itemFactories}) : super();

  @override
  List<Object?> get props => [itemFactories];
}

class ItemFactoryLoadFailure extends ItemFactoryState {
  final String message;
  const ItemFactoryLoadFailure({required this.message}) : super();

  @override
  List<Object> get props => [message];
}
