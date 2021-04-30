part of 'item_factory_bloc.dart';

@immutable
abstract class ItemFactoryEvent extends Equatable {
  const ItemFactoryEvent();
  @override
  List<Object> get props => [];
}

class ItemFactoryRequestEvent extends ItemFactoryEvent {
  const ItemFactoryRequestEvent();
}
