part of 'item_best_stage_bloc.dart';

@immutable
abstract class ItemBestStageEvent extends Equatable {
  const ItemBestStageEvent();
  @override
  List<Object> get props => [];
}

class ItemBestStageRequestEvent extends ItemBestStageEvent {
  final String itemName;
  const ItemBestStageRequestEvent({required this.itemName});
}
