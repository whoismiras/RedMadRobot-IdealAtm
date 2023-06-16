part of 'map_bloc.dart';

class MapState extends Equatable {
  const MapState({
    this.atms = const [],
    this.currentLocation,
    this.markerPoints = const [],
    this.isLocationEnabled = false,
    this.isLoading = false,
    this.error = '',
  });

  final List<Atm> atms;
  final Position? currentLocation;
  final List<LatLng> markerPoints;
  final bool isLocationEnabled;
  final bool isLoading;
  final String error;

  @override
  List<Object?> get props => [
        atms,
        currentLocation,
        markerPoints,
        isLocationEnabled,
        isLoading,
        error
      ];

  MapState copyWith({
    List<Atm>? atms,
    Position? currentLocation,
    List<LatLng>? markerPoints,
    bool? isLocationEnabled,
    bool? isLoading,
    String? error,
  }) {
    return MapState(
      atms: atms ?? this.atms,
      currentLocation: currentLocation ?? this.currentLocation,
      markerPoints: markerPoints ?? this.markerPoints,
      isLocationEnabled: isLocationEnabled ?? this.isLocationEnabled,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? '',
    );
  }

  @override
  String toString() {
    return 'MapState(currentLocation: $currentLocation, markerPoints: $markerPoints, isLocationEnabled: $isLocationEnabled, isLoading: $isLoading, error: $error, \natms: $atms,)';
  }
}
