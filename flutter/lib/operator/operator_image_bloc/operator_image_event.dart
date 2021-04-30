part of 'operator_image_bloc.dart';

@immutable
abstract class OperatorImageEvent extends Equatable {
  const OperatorImageEvent();
  @override
  List<Object> get props => [];
}

class OperatorImageRequestEvent extends OperatorImageEvent {
  const OperatorImageRequestEvent();
}
