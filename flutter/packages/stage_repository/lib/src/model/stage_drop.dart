import 'models.dart';

class StageDrop {
  const StageDrop({
    required this.displayRewards,
    required this.displayDetailRewards,
  });

  final List<StageDropDisplayReward> displayRewards;
  final List<StageDropDisplayReward> displayDetailRewards;
}
