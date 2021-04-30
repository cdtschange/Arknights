import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_best_stage.g.dart';

@JsonSerializable()
class ItemBestStage extends Equatable {
  const ItemBestStage({
    required this.name,
    required this.totalBest,
    required this.singleBest,
  });

  factory ItemBestStage.fromJson(Map<String, dynamic> json) =>
      _$ItemBestStageFromJson(json);

  final String name;
  final List<String> totalBest;
  final List<String> singleBest;

  @override
  List<Object?> get props => [name, totalBest, singleBest];
}
