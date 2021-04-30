import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:item_repository/item_repository.dart';

part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final ItemRepository _itemRepository;
  bool isLoaded = false;

  ItemBloc({required ItemRepository itemRepository})
      : _itemRepository = itemRepository,
        super(ItemInitial());

  @override
  Stream<ItemState> mapEventToState(
    ItemEvent event,
  ) async* {
    if (event is ItemRequestEvent) {
      yield* _mapItemRequestEventToState(event);
    }
  }

  Stream<ItemState> _mapItemRequestEventToState(ItemRequestEvent event) async* {
    yield ItemLoadInProgress();
    try {
      //TODO
      final items = await _itemRepository.fetchItems(false); //!isLoaded
      isLoaded = true;
      yield ItemLoadSuccess(items: items);
    } catch (e) {
      yield ItemLoadFailure(message: e.toString());
    }
  }
}
