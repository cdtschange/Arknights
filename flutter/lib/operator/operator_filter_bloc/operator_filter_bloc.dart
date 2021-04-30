import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'operator_filter_event.dart';
part 'operator_filter_state.dart';

class OperatorFilterBloc
    extends Bloc<OperatorFilterEvent, OperatorFilterState> {
  OperatorFilterBloc() : super(OperatorFilterInitial());

  @override
  Stream<OperatorFilterState> mapEventToState(
    OperatorFilterEvent event,
  ) async* {
    if (event is OperatorFilterChangedEvent) {
      yield* _mapOperatorFilterChangedEventToState(event);
    }
  }

  Stream<OperatorFilterState> _mapOperatorFilterChangedEventToState(
      OperatorFilterChangedEvent event) async* {
    yield OperatorFilterLoadInProgress();
    yield OperatorFilterLoadSuccess(tags: event.tags);
  }
}
