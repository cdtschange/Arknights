part of 'item_best_stage_bloc.dart';

@immutable
abstract class ItemBestStageState extends Equatable {
  const ItemBestStageState();
  @override
  List<Object?> get props => [];
}

class ItemBestStageInitial extends ItemBestStageState {}

class ItemBestStageLoadInProgress extends ItemBestStageState {}

class ItemBestStageLoadSuccess extends ItemBestStageState {
  final ItemBestStage? itemBestStage;

  const ItemBestStageLoadSuccess({required this.itemBestStage}) : super();

  @override
  List<Object?> get props => [itemBestStage];
}

class ItemBestStageLoadFailure extends ItemBestStageState {
  final String message;
  const ItemBestStageLoadFailure({required this.message}) : super();

  @override
  List<Object> get props => [message];
}
