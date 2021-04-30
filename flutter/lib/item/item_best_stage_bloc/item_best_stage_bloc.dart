import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:item_repository/item_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:collection/collection.dart';

part 'item_best_stage_event.dart';
part 'item_best_stage_state.dart';

class ItemBestStageBloc extends Bloc<ItemBestStageEvent, ItemBestStageState> {
  final ItemRepository _itemRepository;
  ItemBestStageBloc({required ItemRepository itemRepository})
      : _itemRepository = itemRepository,
        super(ItemBestStageInitial());

  @override
  Stream<ItemBestStageState> mapEventToState(
    ItemBestStageEvent event,
  ) async* {
    if (event is ItemBestStageRequestEvent) {
      yield* _mapItemBestStageRequestEventToState(event);
    }
  }

  Stream<ItemBestStageState> _mapItemBestStageRequestEventToState(
      ItemBestStageRequestEvent event) async* {
    yield ItemBestStageLoadInProgress();
    try {
      final items = await _itemRepository.fetchItemBestStage();
      final itemBestStage =
          items.firstWhereOrNull((e) => e.name == event.itemName);
      yield ItemBestStageLoadSuccess(itemBestStage: itemBestStage);
    } catch (e) {
      yield ItemBestStageLoadFailure(message: e.toString());
    }
  }
}
