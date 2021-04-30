import 'package:json_annotation/json_annotation.dart';
import 'models.dart';

part 'stage.g.dart';

@JsonSerializable()
class Stage {
  const Stage({
    required this.stageType,
    required this.difficulty,
    required this.performanceStageFlag,
    required this.stageId,
    required this.levelId,
    required this.zoneId,
    required this.code,
    required this.name,
    required this.description,
    required this.hardStagedId,
    required this.dangerLevel,
    required this.dangerPoint,
    required this.loadingPicId,
    required this.canPractice,
    required this.canBattleReplay,
    required this.apCost,
    required this.apFailReturn,
    required this.etCost,
    required this.etFailReturn,
    required this.apProtectTimes,
    required this.diamondOnceDrop,
    required this.practiceTicketCost,
    required this.dailyStageDifficulty,
    required this.expGain,
    required this.goldGain,
    required this.loseExpGain,
    required this.loseGoldGain,
    required this.passFavor,
    required this.completeFavor,
    required this.slProgress,
    required this.displayMainItem,
    required this.hilightMark,
    required this.bossMark,
    required this.isPredefined,
    required this.isHardPredefined,
    required this.isStoryOnly,
    required this.appearanceStyle,
    required this.stageDropInfo,
    required this.isStagePatch,
    required this.mainStageId,
  });

  factory Stage.fromJson(Map<String, dynamic> json) => _$StageFromJson(json);
  Map<String, dynamic> toJson() => _$StageToJson(this);

  @JsonKey(defaultValue: "")
  final String stageType;
  @JsonKey(defaultValue: "")
  final String difficulty;
  @JsonKey(defaultValue: "")
  final String performanceStageFlag;
  @JsonKey(defaultValue: "")
  final String stageId;
  @JsonKey(defaultValue: "")
  final String levelId;
  @JsonKey(defaultValue: "")
  final String zoneId;
  @JsonKey(defaultValue: "")
  final String code;
  @JsonKey(defaultValue: "")
  final String name;
  @JsonKey(defaultValue: "")
  final String description;
  final String? hardStagedId;
  final String? dangerLevel;
  final double? dangerPoint;
  final String? loadingPicId;
  final bool canPractice;
  final bool canBattleReplay;
  final int apCost;
  final int apFailReturn;
  final int etCost;
  final int etFailReturn;
  final int apProtectTimes;
  final int diamondOnceDrop;
  final int practiceTicketCost;
  final int dailyStageDifficulty;
  final int expGain;
  final int goldGain;
  final int loseExpGain;
  final int loseGoldGain;
  final int passFavor;
  final int completeFavor;
  final int slProgress;
  final String? displayMainItem;
  final bool hilightMark;
  final bool bossMark;
  final bool isPredefined;
  final bool isHardPredefined;
  final bool isStoryOnly;
  final int appearanceStyle;
  final StageDrop? stageDropInfo;
  final bool isStagePatch;
  @JsonKey(defaultValue: "")
  final String mainStageId;

  bool get isStageTypeMainOrSub {
    return stageType == "MAIN" || stageType == "SUB";
  }
}
