part of 'zone_bloc.dart';

@immutable
abstract class ZoneState extends Equatable {
  const ZoneState();
  @override
  List<Object> get props => [];
}

class ZoneInitial extends ZoneState {}

class ZoneLoadInProgress extends ZoneState {}

class ZoneLoadSuccess extends ZoneState {
  final List<Zone> zones;

  const ZoneLoadSuccess({required this.zones}) : super();

  @override
  List<Object> get props => [zones];
}

class ZoneLoadFailure extends ZoneState {
  final String message;
  const ZoneLoadFailure({required this.message}) : super();

  @override
  List<Object> get props => [message];
}
