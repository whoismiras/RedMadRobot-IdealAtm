// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';

import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ideal_atm/main/business/models/atm/atm.dart';
import 'package:ideal_atm/main/data/providers/atm_provider.dart';
import 'package:latlong2/latlong.dart' show LatLng;

part 'map_event.dart';

part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  void requestPermissions() => add(MapRequestPermissionsEvent());

  void getCurrentLocation() => add(MapGetCurrentLocationEvent());

  void addMarkers(List<Atm> atms) => add(MapAddMarkersEvent(atms));

  MapBloc() : super(const MapState()) {
    on<MapRequestPermissionsEvent>(_requestPermissions);
    on<MapGetCurrentLocationEvent>(_getCurrentLocation);
  }

  final AtmProvider atmData = AtmProvider();

  void _requestPermissions(
      MapRequestPermissionsEvent event, Emitter<MapState> emit) async {
    emit(state.copyWith(isLoading: true));

    final isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      return emit(state.copyWith(
        isLoading: false,
        error: 'location_disabled',
      ));
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return emit(state.copyWith(
          isLoading: false,
          error: 'location_denied',
        ));
      }
    }

    if (permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      return emit(state.copyWith(
        isLoading: false,
        error: 'location_permanent',
      ));
    }

    return getCurrentLocation();
  }

  void _getCurrentLocation(
      MapGetCurrentLocationEvent event, Emitter<MapState> emit) async {
    final location = await Geolocator.getCurrentPosition();
    emit(
      state.copyWith(currentLocation: location),
    );
    _addMarkers();
  }

  void _addMarkers() async {
    try {
      final markers = await atmData.fetchAtms();

      emit(state.copyWith(atms: markers));
    } catch (e) {
      debugPrint('MapAddMarkersEvent error: $e');
      emit(state.copyWith(error: 'something_went_wrong'));
    }
  }
}
