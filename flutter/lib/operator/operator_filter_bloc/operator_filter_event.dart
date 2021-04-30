part of 'operator_filter_bloc.dart';

@immutable
abstract class OperatorFilterEvent extends Equatable {
  const OperatorFilterEvent();
  @override
  List<Object> get props => [];
}

class OperatorFilterChangedEvent extends OperatorFilterEvent {
  final Map<String, List<String>> tags;
  const OperatorFilterChangedEvent({required this.tags});
}
