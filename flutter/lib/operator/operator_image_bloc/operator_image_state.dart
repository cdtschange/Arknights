part of 'operator_image_bloc.dart';

@immutable
abstract class OperatorImageState extends Equatable {
  const OperatorImageState();
  @override
  List<Object> get props => [];
}

class OperatorImageInitial extends OperatorImageState {
  const OperatorImageInitial() : super();
}

class OperatorImageLoadInProgress extends OperatorImageState {
  const OperatorImageLoadInProgress() : super();
}

class OperatorImageLoadSuccess extends OperatorImageState {
  final List<OperatorImage> operatorImages;

  const OperatorImageLoadSuccess({required this.operatorImages}) : super();

  @override
  List<Object> get props => [operatorImages];
}

class OperatorImageLoadFailure extends OperatorImageState {
  final String message;
  const OperatorImageLoadFailure({required this.message}) : super();

  @override
  List<Object> get props => [message];
}
