import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:item_repository/item_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'item_drop_event.dart';
part 'item_drop_state.dart';

class ItemDropBloc extends Bloc<ItemDropEvent, ItemDropState> {
  final ItemRepository _itemRepository;
  bool isLoaded = false;
  ItemDropBloc({required ItemRepository itemRepository})
      : _itemRepository = itemRepository,
        super(ItemDropInitial());

  @override
  Stream<ItemDropState> mapEventToState(
    ItemDropEvent event,
  ) async* {
    if (event is ItemDropRequestEvent) {
      yield* _mapItemDropRequestEventToState(event);
    }
  }

  Stream<ItemDropState> _mapItemDropRequestEventToState(
      ItemDropRequestEvent event) async* {
    yield ItemDropLoadInProgress();
    try {
      //TODO
      final allItemDrops = await _itemRepository.fetchItemDrops(refresh: false);
      // final allItemDrops =
      //     await _itemRepository.fetchItemDrops(refresh: !isLoaded);
      isLoaded = true;
      yield ItemDropLoadSuccess(itemDrops: allItemDrops);
    } catch (e) {
      yield ItemDropLoadFailure(message: e.toString());
    }
  }
}
