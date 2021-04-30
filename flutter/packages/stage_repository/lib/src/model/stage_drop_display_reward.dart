class StageDropDisplayReward {
  const StageDropDisplayReward({
    required this.type,
    required this.id,
    required this.dropType,
    required this.occPercent,
  });

  final String type;
  final String id;
  final int dropType;
  final int? occPercent;
}
