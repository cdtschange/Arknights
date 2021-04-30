import 'package:equatable/equatable.dart';

class ItemDrop extends Equatable {
  const ItemDrop({
    required this.stageId,
    required this.itemId,
    required this.quantity,
    required this.times,
    required this.start,
  });

  final String stageId;
  final String itemId;
  final int quantity;
  final int times;
  final int start;

  @override
  List<Object?> get props => [stageId, itemId, quantity, times, start];

  double get rate {
    return quantity / times;
  }
}
