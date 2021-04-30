import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:item_repository/item_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'item_factory_event.dart';
part 'item_factory_state.dart';

class ItemFactoryBloc extends Bloc<ItemFactoryEvent, ItemFactoryState> {
  final ItemRepository _itemRepository;
  ItemFactoryBloc({required ItemRepository itemRepository})
      : _itemRepository = itemRepository,
        super(ItemFactoryInitial());

  @override
  Stream<ItemFactoryState> mapEventToState(
    ItemFactoryEvent event,
  ) async* {
    if (event is ItemFactoryRequestEvent) {
      yield* _mapItemFactoryRequestEventToState(event);
    }
  }

  Stream<ItemFactoryState> _mapItemFactoryRequestEventToState(
      ItemFactoryRequestEvent event) async* {
    yield ItemFactoryLoadInProgress();
    try {
      final itemFactories = await _itemRepository.fetchItemFactory();
      yield ItemFactoryLoadSuccess(itemFactories: itemFactories);
    } catch (e) {
      yield ItemFactoryLoadFailure(message: e.toString());
    }
  }
}
