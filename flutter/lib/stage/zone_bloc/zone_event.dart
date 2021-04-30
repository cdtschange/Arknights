part of 'zone_bloc.dart';

@immutable
abstract class ZoneEvent extends Equatable {
  const ZoneEvent();
  @override
  List<Object> get props => [];
}

class ZoneRequestEvent extends ZoneEvent {
  const ZoneRequestEvent();
}
