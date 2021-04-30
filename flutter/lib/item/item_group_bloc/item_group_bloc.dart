import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:item_repository/item_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'item_group_event.dart';
part 'item_group_state.dart';

class ItemGroupBloc extends Bloc<ItemGroupEvent, ItemGroupState> {
  final ItemRepository _itemRepository;
  var isPrimary = true;

  ItemGroupBloc({required ItemRepository itemRepository})
      : _itemRepository = itemRepository,
        super(ItemGroupInitial());

  @override
  Stream<ItemGroupState> mapEventToState(
    ItemGroupEvent event,
  ) async* {
    if (event is ItemGroupRequestEvent) {
      yield* _mapItemGroupRequestEventToState(event);
    }
    if (event is ItemGroupSwitchEvent) {
      yield* _mapItemGroupSwitchEventToState(event);
    }
  }

  Stream<ItemGroupState> _mapItemGroupRequestEventToState(
      ItemGroupRequestEvent event) async* {
    yield ItemGroupLoadInProgress(isPimary: isPrimary);
    try {
      final groups =
          await _itemRepository.fetchItemGroups(isPrimary: event.isPrimary);
      yield ItemGroupLoadSuccess(isPimary: isPrimary, groups: groups);
    } catch (e) {
      yield ItemGroupLoadFailure(message: e.toString(), isPimary: isPrimary);
    }
  }

  Stream<ItemGroupState> _mapItemGroupSwitchEventToState(
      ItemGroupSwitchEvent event) async* {
    try {
      final groups =
          await _itemRepository.fetchItemGroups(isPrimary: event.isPrimary);
      isPrimary = event.isPrimary;
      yield ItemGroupSwitchSuccess(isPimary: isPrimary, groups: groups);
    } catch (e) {
      yield ItemGroupSwitchFailure(message: e.toString(), isPimary: isPrimary);
    }
  }
}
