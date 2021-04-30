import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:operator_repository/operator_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'operator_image_event.dart';
part 'operator_image_state.dart';

class OperatorImageBloc extends Bloc<OperatorImageEvent, OperatorImageState> {
  final OperatorRepository _operatorRepository;

  OperatorImageBloc({required OperatorRepository operatorRepository})
      : _operatorRepository = operatorRepository,
        super(OperatorImageInitial());

  @override
  Stream<OperatorImageState> mapEventToState(
    OperatorImageEvent event,
  ) async* {
    if (event is OperatorImageRequestEvent) {
      yield* _mapOperatorImageRequestEventToState(event);
    }
  }

  Stream<OperatorImageState> _mapOperatorImageRequestEventToState(
      OperatorImageRequestEvent event) async* {
    yield OperatorImageLoadInProgress();
    try {
      final operatorImages = await _operatorRepository.fetchOperatorImages();
      yield OperatorImageLoadSuccess(operatorImages: operatorImages);
    } catch (e) {
      yield OperatorImageLoadFailure(message: e.toString());
    }
  }
}
