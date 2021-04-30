import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:item_repository/item_repository.dart';

part 'item_detail_event.dart';
part 'item_detail_state.dart';

class ItemDetailBloc extends Bloc<ItemDetailEvent, ItemDetailState> {
  final ItemRepository _itemRepository;

  ItemDetailBloc({required ItemRepository itemRepository})
      : _itemRepository = itemRepository,
        super(ItemDetailInitial());

  @override
  Stream<ItemDetailState> mapEventToState(
    ItemDetailEvent event,
  ) async* {
    if (event is ItemDetailRequestEvent) {
      yield* _mapItemDetailRequestEventToState(event);
    }
  }

  Stream<ItemDetailState> _mapItemDetailRequestEventToState(
      ItemDetailRequestEvent event) async* {
    yield ItemDetailLoadInProgress();
    try {
      final itemDetails = await _itemRepository.fetchItemDetails();
      yield ItemDetailLoadSuccess(itemDetails: itemDetails);
    } catch (e) {
      yield ItemDetailLoadFailure(message: e.toString());
    }
  }
}
