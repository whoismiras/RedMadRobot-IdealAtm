part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class MapRequestPermissionsEvent extends MapEvent {}

class MapGetCurrentLocationEvent extends MapEvent {}

class MapAddMarkersEvent extends MapEvent {
  final List<Atm> atms;

  const MapAddMarkersEvent(this.atms);
}
